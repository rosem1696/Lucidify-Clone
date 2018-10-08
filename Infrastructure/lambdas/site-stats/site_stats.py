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

	db_cur.execute('SELECT * FROM main.sitewide_get_num_listens()')
	num_listens = int(db_cur.fetchone()[0])
	db_cur.execute('SELECT * FROM main.sitewide_get_num_genres()')
	num_genres = int(db_cur.fetchone()[0])
	db_cur.execute('SELECT * FROM main.sitewide_get_num_users()')
	num_users = int(db_cur.fetchone()[0])

	return {
		'body': json.dumps({
			'listens': num_listens,
			'genres': num_genres,
			'users': num_users
		}),
		'statusCode': 200,
		'headers': {
            'X-Requested-With': '*',
            'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,x-requested-with',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,OPTIONS'
        }
	}
