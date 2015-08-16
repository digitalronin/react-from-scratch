IMG_TAG   := react-img
CONTAINER := react-cnt

# Run bundler in the docker image to create Gemfile.lock
bundle:
	docker run --rm \
		-v $$(pwd):/app \
		-w /app \
		ruby:2.2 gem install bundler && bundle install --jobs 20 --retry 5

# Build the docker image which runs the app.
image:
	docker build -t $(IMG_TAG) .


# Run a shell on the container
shell:
	docker run --rm \
		--name $(CONTAINER) \
		-e TERM=vt100 \
		-v $$(pwd):/app \
		-it $(IMG_TAG) /bin/bash


# Compile JSX to public/application.js
compile:
	docker run --rm \
		--name $(CONTAINER) \
		-v $$(pwd):/app \
		$(IMG_TAG) bash -c 'cat components/*.jsx | babel > public/application.js'


# Run the web application container
run:
	docker run --rm \
		--net  host \
		--name $(CONTAINER) \
		-e TERM=vt100 \
		-v $$(pwd):/app \
		$(IMG_TAG)


