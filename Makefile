build:
	docker compose up --build

start:
	docker compose up

stop:
	docker compose stop

rc:
	docker compose run --rm chovehoje rails console

tweet:
	@:$(call check_defined, cid, Please provide a cid as argument: 'make tweet cid=5128581')
	curl -X POST -H "Content-Type: application/json" -d '{"city_id": "${cid}"}' http://localhost:3000/twitter/tweets
.PHONY: tweet

# Function to check if variables are defined
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))

__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))