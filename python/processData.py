from covidapp.operations import *
from covidapp.dataops import *
import argparse
import logging


logger = logging.getLogger()
logger.setLevel(logging.INFO)

argParser = argparse.ArgumentParser(fromfile_prefix_chars='@',usage='%(prog)s [options]', prog='covidapp')

argParser.add_argument('-v',
                       '--verbose',
                       action='store_true',
                       help='verbose')
requiredArgs = argParser.add_argument_group('Required Arguments')
requiredArgs.add_argument('-f',
                          '--folder',
                          type=str,
                          required=True,
                          help='data folder in container')

requiredArgs.add_argument('-d',
                          '--database',
                          type=str,
                          required=True,
                          help='db name')
args = argParser.parse_args()


def processRawData():
    try:
        print("PARSING DATA...")
        logger.info("Processing raw data" )
        # Next Steps
        #dp=dataParser()
        #dp.parseFile(RAWDATA)
        #database.connect('')
        #database.insertDataToDb('')
        #database.disconnect('')
        #analyzeData.analyze('')

    except Exception as e:
        print(str(e))

def print_test(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM TEST")
        rows = cur.fetchall()
        conn.commit()

        for row in rows:
            print([str(cell) for cell in row])


if __name__ == '__main__':
    logger.info("Connecting CRDB:")
    print("Connecting CRDB...")
    conn = database.crdb_connect('coviddb', 'coviduser', 'covidpass')
    print("Connected!")
    print_test(conn)

    database.disconnect(conn)

    #processRawData()



