# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install Git
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean


WORKDIR /

# Create the SSH directory
RUN mkdir -p /root/.ssh

# Copy your SSH keys into the image (ensure they're in the same directory as the Dockerfile)
COPY .ssh/id_rsa /root/.ssh/id_rsa
COPY .ssh/id_rsa.pub /root/.ssh/id_rsa.pub

# Set appropriate permissions
RUN chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts


# Set the working directory
WORKDIR /app

# Clone the specified GitHub repository
RUN git clone git@github.com:bobblePandey/mixxx.git

# Set the working directory to the cloned repository
WORKDIR /app/mixxx

# Check out the specific branch
RUN git checkout dockerSetup

RUN ./tools/debian_buildenv.sh setup

# Optionally, you can specify a command to run when the container starts
CMD ["bash"]

