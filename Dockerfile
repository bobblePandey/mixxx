# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install Git
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean


# Set the working directory
WORKDIR /app
COPY ./tools/debian_buildenv.sh /app
RUN ./debian_buildenv.sh setup

# Optionally, you can specify a command to run when the container starts
CMD ["bash"]

