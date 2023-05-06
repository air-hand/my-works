# Try Docker Buildx Bake

## Motivation

I want to extend a Dockerfile with another Dockerfile. Without building a base image.

There are some solutions like below, but these are not make sense.

* Write a script to build a base image, followed by a custom image.
* Building a dockerfile with c preprocessor and makefile.

## Experimental

This is possible with Docker buildx bake, but devcontainer does not support it.

## Links

[Bake Overview](https://docs.docker.com/build/bake/)
