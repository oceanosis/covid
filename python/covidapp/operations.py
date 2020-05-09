from git import Repo
import psycopg2
import time
import logging
import random

class downloadData:

    @staticmethod
    def gitClone(REMOTE_URL,DATADIR):
        try:
            Repo.clone_from(REMOTE_URL,DATADIR)
        except Exception as e:
            print(str(e))
        finally:
            print('Cloning done from %s' % REMOTE_URL)


class database:

    @staticmethod
    def crdb_connect( DBNAME, USER, PASSWORD):
        try:
            conn = psycopg2.connect(
                database='DBNAME',
                user='USER',
                password='PASSWORD',
                sslmode='require',
                sslrootcert='certs/ca.crt',
                sslkey='certs/client.root.key',
                sslcert='certs/client.root.crt',
                port=26257,
                host='172.18.0.2'
            )
            return conn
        except Exception as e:
            print(str(e))

    @staticmethod
    def disconnect(conn):
        conn.close()

    def insertCSV(self):
        print('')




