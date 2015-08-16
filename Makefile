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

# Run the docker image, mounting pwd as /app
run:
	docker run --rm \
		--net  host \
		--name $(CONTAINER) \
		-e TERM=vt100 \
		-v $$(pwd):/app \
		$(IMG_TAG)


