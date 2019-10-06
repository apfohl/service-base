IMAGE=apfohl/service-base:development
CONTAINER=base

.PHONY: build run shell rm logs

build:
	@docker build -t $(IMAGE) .

run:
	@docker run --name=$(CONTAINER) -e TZ="Europe/Berlin" -h base -d $(IMAGE)

shell:
	@docker exec -it $(CONTAINER) sh

rm:
	@docker rm -f $(CONTAINER)

logs:
	@docker logs $(CONTAINER)
