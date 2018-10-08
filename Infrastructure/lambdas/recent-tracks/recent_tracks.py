import spotipy
import json
import pg8000

DATABASE_URI = "lucidifydb.crcbmpp2gcpp.us-east-1.rds.amazonaws.com"
DATABASE_USERNAME = "lucidify"
DATABASE_PASSWORD = "REMOVED"

db_conn = pg8000.connect(
    database='LucidifyDB',
    user=DATABASE_USERNAME,
    password=DATABASE_PASSWORD,
    host=DATABASE_URI,
    port=5432
)

def lambda_handler(event, context):
    db_cur = db_conn.cursor()

    qs_params = event.get('queryStringParameters')
    if qs_params is None:
        return {'statusCode': 400}

    auth_token = qs_params.get('token')
    if auth_token is None:
        return {'statusCode': 400}

    sp = spotipy.Spotify(auth=auth_token)
    email = sp.me()['email']
    db_cur.execute("SELECT user_id FROM main.users WHERE email = %s", (email,))
    user_id = db_cur.fetchone()[0]

    recents = sp.current_user_recently_played()
    songs = [{'artists': list(zip([z['id'] for z in y[0]['artists']], [z['name'] for z in y[0]['artists']])),
              'trackname': y[0]['name'],
              'detailurl': y[0]['external_urls']['spotify'],
              'album': (y[0]['album']['id'], y[0]['album']['name']),
              'played_at': y[1]}
             for y in
             [[x['track'], x['played_at']] for x in recents['items']]]

    for song in songs:
        url = song['detailurl']
        db_cur.execute(
            'SELECT main.insert_song(%s, %s)',
            (url[url.index('/track') + 7:], json.dumps({'trackname': song['trackname'],
                                                        'detailurl': url,
                                                        'album': song['album']})))

    db_conn.commit()

    all_artist_ids = [x[0] for z in [y['artists'] for y in songs] for x in z]
    all_album_ids = [x['album'][0] for x in songs]

    all_artist_data = []
    idx = 0
    while idx < len(all_artist_ids):
        all_artist_data = all_artist_data + (sp.artists(all_artist_ids[idx:idx + 20])['artists'])
        idx = idx + 20

    for artist in all_artist_data:
        db_cur.execute(
            'SELECT main.insert_artist(%s, %s)',
            (artist['id'], json.dumps({'artistname': artist['name'],
                                       'detailurl': artist['external_urls']['spotify'],
                                       'imageurl': artist['images'][0]['url'] if 'images' in artist and len(artist['images']) > 0 else ''})))

    db_conn.commit()

    for song in songs:
        url = song['detailurl']
        song_id = url[url.index('/track') + 7:]
        for artist in song['artists']:
            db_cur.execute("SELECT main.insert_artist_song(%s, %s)",
                           (artist[0], song_id))

    db_conn.commit()

    for song in songs:
        url = song['detailurl']
        song_id = url[url.index('/track') + 7:]
        db_cur.execute("SELECT main.insert_user_play_record(%s, %s, %s)",
                       (user_id, song_id, song['played_at']))

    db_conn.commit()

    all_albums_data = {'albums': []}
    idx = 0
    while idx < len(all_album_ids):
        all_albums_data['albums'] = all_albums_data['albums'] + (sp.albums(all_album_ids[idx:idx + 20])['albums'])
        idx = idx + 20

    genres = set()
    for song in songs:
        song_artist_ids = [x[0] for x in song['artists']]
        artists_data = {'artists': list(filter(lambda x: x['id'] in song_artist_ids, all_artist_data))}

        artist_urls = [(x['images'][0]['url'] if len(x['images']) > 0 else None, x['external_urls']['spotify']) for x in
                       artists_data['artists']]
        song['artists'] = list(map(lambda x, y: x + y, song['artists'], artist_urls))

        album = list(filter(lambda x: x['id'] == song['album'][0], all_albums_data['albums']))[0]
        if len(album['genres']) > 0:
            song_genres = album['genres']
            song['genres'] = song_genres
            genres.update(song_genres)

        else:
            artists = [x[0] for x in song['artists']]
            song['genres'] = []
            for artist in artists:
                song_genres = list(filter(lambda x: x['id'] == artist, all_artist_data))[0]['genres']
                song['genres'] += song_genres
                genres.update(song_genres)

    genre_list = [{'name': x, 'size': 0, 'artists': []} for x in list(genres)]

    def add_artist(artist, genre):
        item_to_append = next(x for x in genre_list if x['name'] == genre)

        if artist[1] in [x['name'] for x in item_to_append['artists']]: return

        artist_songs = list(filter(lambda x: artist[0] in [y[0] for y in x['artists']], songs))

        songs_object = []
        for artist_song in artist_songs:
            if artist_song['detailurl'] in [x['song_detail_url'] for x in songs_object]:
                increment_song = next(x for x in songs_object if x['song_detail_url'] == artist_song['detailurl'])
                increment = increment_song['num_times_listened']
                increment_song['num_times_listened'] = increment + 1
            else:
                songs_object.append({
                    'name': artist_song['trackname'],
                    'num_times_listened': 1,
                    'song_detail_url': artist_song['detailurl']
                })

        item_to_append['artists'].append({
            'name': artist[1],
            'artist_picture_url': artist[2],
            'artist_detail_url': artist[3],
            'songs': songs_object
        })

    [[[add_artist(artist, genre) for artist in song['artists']] for genre in song['genres']] for song in songs]

    for genre in genre_list:
        genre_songs_unique = []
        for artist in genre['artists']:
            for song in artist['songs']:
                if song not in genre_songs_unique: genre_songs_unique.append(song)
        genre['size'] = sum(x['num_times_listened'] for x in genre_songs_unique)

    genre_list = sorted(genre_list, key=lambda x: x['size'], reverse=True)
    for genre in genre_list:
        for artist in genre['artists']:
            for song in artist['songs']:
                url = song['song_detail_url']
                song_id = url[url.index('/track') + 7:]
                db_cur.execute("SELECT main.insert_song_genre(%s, %s)",
                               (song_id, genre['name']))

    db_conn.commit()

    db_return_object = {'genres': []}

    db_cur.execute('SELECT * FROM main.get_user_genres(%s)', (user_id,))
    for (count, genre_name) in db_cur.fetchall():
        db_return_object['genres'].append({'name': genre_name, 'size': int(count), 'artists': []})

    db_cur.execute('SELECT * FROM main.get_user_artists(%s)', (user_id,))
    for (artist, genre, image_url, detail_url) in db_cur.fetchall():
        next(x for x in db_return_object['genres'] if x['name'] == genre)['artists'].append({
            'name': artist,
            'artist_picture_url': image_url,
            'artist_detail_url': detail_url,
            'songs': []
        })

    db_cur.execute('SELECT * FROM main.get_user_artist_songs1(%s)', (user_id,))
    for (num, track_name, artist, detail_url, listened_at) in db_cur.fetchall():
        for genre in db_return_object['genres']:
            if artist in [artist['name'] for artist in genre['artists']]:
                next(x for x in genre['artists'] if x['name'] == artist)['songs'].append({
                    'name': track_name,
                    'num_times_listened': num,
                    'song_detail_url': detail_url,
                    'listened_at': listened_at.timestamp()
                })

    return_object = db_return_object

    return {
        'body': json.dumps(return_object),
        'statusCode': 200,
        'headers': {
            'X-Requested-With': '*',
            'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,x-requested-with',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,OPTIONS'
        }
    }
