from git import Repo

class cloningRepo:
    def __init__(self):
        print('Cloning repo...' )

    def gitClone(self,DATADIR,REMOTE_URL):

        try:
            Repo.clone_from(REMOTE_URL,DATADIR)
        except Exception as e:
            print(str(e))
        finally:
            print('Cloning done from %s' % self.REMOTE_URL)

class parser:
    def __init__(self):
        self.DATADIR = DATADIR

    def parseFile(self):
        print('source data: %s' % self.DATADIR)

class database:
    def __init__(self):
        self.DATADIR = DATADIR

    def connect(self):
        print('')

    def disconnect(self):
        print('')

    def insertDataToDb(self):
        print('')




