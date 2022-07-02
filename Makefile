IMAGE_NAME := hidori/node-chrome-ja

.PHONY: build
build:
	docker build -f ./Dockerfile -t ${IMAGE_NAME}:latest .

.PHONY: rebuild
rebuild:
	docker build -f ./Dockerfile -t ${IMAGE_NAME}:latest --no-cache .

.PHONY: rmi
rmi:
	docker rmi -f ${IMAGE_NAME}

.PHONY: pull
pull: rmi
	docker pull ${IMAGE_NAME}

.PHONY: run
run:
	docker run -it --rm --privileged \
		-u `id -u`:`id -g` \
		-v $$PWD/tmp:/workdir \
		$(IMAGE_NAME) \
		google-chrome --no-sandbox --headless --screenshot=/workdir/screenshot.png --window-size=1024,768 https://www.google.co.jp
