all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make server       - run server

server: NAME TAG PORT DATA_DIR serverplay

serverplay:
	ansible-playbook -i inventory `cat NAME`.yml

prep: bootstrap docker

docker:
	ansible-playbook -i inventory docker.yml

bootstrap:
	ansible-playbook -i inventory bootstrapAnsible.yml

inventory:
	cp -i inventory.example inventory

prepcoreos: .prepcoreos

.prepcoreos:
	ansible-galaxy install defunctzombie.coreos-bootstrap -p ./roles
	cat inventory-coreos-additions.example >> inventory
	-@echo `date -I`>.prepcoreos
	-@echo 'Now edit inventory and ensure all coreos hosts are within the coreos group'

coreosbootstrap: .coreosbootstrapped

.coreosbootstrapped:
	-@echo -n '-vvvv for extra help here as this only runs once'
	-@sleep 1
	-@echo -n '.'
	-@sleep 1
	-@echo -n '.'
	-@sleep 1
	-@echo -n '.'
	ansible-playbook -vvvv -i inventory coreosbootstrap.yml
	-@echo `date -I`>.coreosbootstrapped

PORT:
	@while [ -z "$$PORT" ]; do \
		read -r -p "Enter the PORT of the Docker server you wish to associate with this agent : " PORT; echo "$$PORT">>PORT; cat PORT; \
	done ;

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

TAG:
	@while [ -z "$$TAG" ]; do \
		read -r -p "Enter the TAG you wish to associate with this container [TAG]: " TAG; echo "$$TAG">>TAG; cat TAG; \
	done ;

DATA_DIR:
	@while [ -z "$$DATA_DIR" ]; do \
		read -r -p "Enter the DATA_DIR you wish to associate with this container [DATA_DIR]: " DATA_DIR; echo "$$DATA_DIR">>DATA_DIR; cat DATA_DIR; \
	done ;
