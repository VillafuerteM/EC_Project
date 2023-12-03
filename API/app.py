from flask import Flask, request
import json
import psycopg2
import psycopg2.extras
import os

# Estructura del uri:
# "motor://user:password@host:port/database"
database_uri = f'postgresql://{os.environ["PGUSR"]}:{os.environ["PGPASS"]}@{os.environ["PGHOST"]}:5432/{os.environ["PGDB"]}'

app = Flask(__name__)
conn = psycopg2.connect(database_uri)


def execute_query(query, conn=conn):
    cur = conn.cursor(cursor_factory=psycopg2.extras.NamedTupleCursor)
    try:
        cur.execute(query)
        results = cur.fetchall()
    except Exception as e:
        print(f"Error on the query: {e}")
        results = []
    cur.close()
    return json.dumps([x._asdict() for x in results], default=str)


@app.route("/winequality", methods=["GET"])
def winequality():
    query = "select * from winequality limit 100"
    return execute_query(query)


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=8080)
