import git

REMOTE_URL='https://github.com/CSSEGISandData/COVID-19.git'
DATADIR='/data'

class operations():
    try:
        def __init__(self):
            self.DATADIR = DATADIR
            self.REMOTE_URL = REMOTE_URL

        def git_clone(self):
            print('Cloning source data into %s' % DATADIR)
            try:
                git.Repo.clone_from(REMOTE_URL, DATADIR)
            except Exception as e:
                    print(str(e))
            finally:
                print('Cloning done from %s' % REMOTE_URL)
    except Exception as e:
        print(str(e))



if __name__ == '__main__':
    operations()
    operations.git_clone('')
