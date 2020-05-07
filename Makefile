
.PHONY: help
help:            ## Help for command list
	@echo ""
	@echo "Deploy covidapp"
	@echo ""
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: deploy
deploy:		## Deploy full covidapp stack
	@echo "Deploy all containers - download latest data"
	./buildContainers
	./runDb
	./getData


.PHONY: getdata
getdata:	## Download latest data
	@echo ""
	./buildContainers
	./getData

.PHONY: stop
destroy:	## Destroy all resources
	@echo "destroy all"
	./scripts/destroy.sh


.PHONY: testdata
testdata:	## Test data integrity etc...
	@echo "TEST DATA RUNNNING....."


