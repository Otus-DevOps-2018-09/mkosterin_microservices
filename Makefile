UN=mkosterin

all: reddit monitoring deploy

reddit: comment post ui
monitoring: prometheus alertmanager
deploy: deploy-reddit deploy-monitoring
undeploy: undeploy-monitoring undeploy-reddit

comment:
	export USER_NAME=$(UN) && cd src/comment && bash docker_build.sh && docker push $(UN)/comment
post:
	export USER_NAME=$(UN) && cd src/post-py && bash docker_build.sh && docker push $(UN)/post
ui:
	export USER_NAME=$(UN) && cd src/ui && bash docker_build.sh && docker push $(UN)/ui
prometheus:
	export USER_NAME=$(UN) && cd monitoring/prometheus && docker build -t $(UN)/prometheus . && docker push $(UN)/prometheus
alertmanager:
	export USER_NAME=$(UN) && cd monitoring/alertmanager && docker build -t $(UN)/alertmanager . && docker push $(UN)/alertmanager
deploy-reddit:
	export USER_NAME=$(UN) && cd docker && docker-compose up -d
deploy-monitoring:
	export USER_NAME=$(UN) && cd docker && docker-compose -f docker-compose-monitoring.yml up -d
undeploy-reddit:
	export USER_NAME=$(UN) && cd docker && docker-compose down
undeploy-monitoring:
	export USER_NAME=$(UN) && cd docker && docker-compose -f docker-compose-monitoring.yml down

