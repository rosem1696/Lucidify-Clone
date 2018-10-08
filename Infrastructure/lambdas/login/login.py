import spotipy
import spotipy.oauth2
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
    SPOTIFY_CLIENT_ID = 'REMOVED'
    SPOTIFY_CLIENT_SECRET = 'REMOVED'
    REDIRECT_URI = "https://api.lucidi.fi/v1/login"

    db_cur = db_conn.cursor()

    qs_params = event.get('queryStringParameters')
    if qs_params is None: return { 'statusCode': 400 }

    auth_code = qs_params.get('code')
    if auth_code is None: return { 'statusCode': 401 }

    auth_state = qs_params.get('state')

    if qs_params == None or auth_code == None:
        return {
            'statusCode': 400
        }

    oauth_creds = spotipy.oauth2.SpotifyOAuth(client_id=SPOTIFY_CLIENT_ID, client_secret=SPOTIFY_CLIENT_SECRET,
                                              redirect_uri=REDIRECT_URI)

    try:
        auth_token = oauth_creds.get_access_token(auth_code)
    except spotipy.oauth2.SpotifyOauthError:
        auth_token = None

    if auth_token == None:
        return {
            'statusCode': 401
        }

    sp_client = spotipy.Spotify(auth=auth_token['access_token'])
    user = sp_client.me()

    if 'email' in user and user['email'] is not None:
        email = user['email']
    else:
        email = user['uri']

    db_cur.execute("INSERT INTO main.users (email, last_login) VALUES (%s, NOW() AT TIME ZONE 'UTC') "
                   "ON CONFLICT (email) DO UPDATE SET last_login = NOW() AT TIME ZONE 'UTC'", (email,))
    db_conn.commit()

    return {
        'statusCode': 302,
        'headers' : {
            'Location': 'https://www.lucidi.fi/?access_token={}&refresh_token={}'.format(auth_token['access_token'], auth_token['refresh_token'])
        }
    }
