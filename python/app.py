from covidapp.operations import *
from covidapp.dataops import *

def getRawData():
    try:
        cloningRepo().gitClone(RAWDATA,REPO_URL)

    except Exception as e:
        print(str(e))

def processRawData():
    try:
        # Next Steps
        parser.parseFile('')
        database.connect('')
        database.insertDataToDb('')
        database.disconnect('')
        analyzeData.analyze('')

    except Exception as e:
        print(str(e))

if __name__ == "__main__":
    RAWDATA="/data"
    REPO_URL="https://github.com/CSSEGISandData/COVID-19.git"
    getRawData()


