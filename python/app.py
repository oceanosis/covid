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

requiredArgs.add_argument('-u',
                          '--url',
                          type=str,
                          required=True,
                          help='git repo url')
args = argParser.parse_args()


def getRawData(RAWDATA,REPO_URL):
    try:
        getData = downloadData()
        getData.gitClone(REPO_URL,RAWDATA)

    except Exception as e:
        print(str(e))

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


if __name__ == '__main__':
    logger.info("Getting raw data from %s" % args.url)
    print(args.url)
    getRawData(args.folder,args.url)
    processRawData()



