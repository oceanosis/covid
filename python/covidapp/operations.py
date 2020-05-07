from git import Repo

class downloadData:

    @staticmethod
    def gitClone(REMOTE_URL,DATADIR):
        try:
            Repo.clone_from(REMOTE_URL,DATADIR)
        except Exception as e:
            print(str(e))
        finally:
            print('Cloning done from %s' % REMOTE_URL)


class dataParser:
    def __init__(self,DATADIR):
        self.DATADIR = DATADIR

    def parseFile(self):
        print('source data: %s' % self.DATADIR)

class database:
    def connect(self):
        print('')

    def disconnect(self):
        print('')

    def insertDataToDb(self):
        print('')




