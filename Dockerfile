# The Dockerfile for running programs using AFL-generated test cases.
FROM ubuntu:24.04

# Install necessary tools and dependencies
RUN apt-get update \
    && apt-get install -y build-essential bc \
    && apt-get clean

# Set the default working directory
WORKDIR /app/

# Use ARG to specify the test case directory (e.g., 01-quickstart, 02-harness)
ARG TEST_CASE
ENV TEST_CASE=${TEST_CASE}

# Copy the specified test case into the container
COPY ${TEST_CASE} /app/

# Build the program using the provided Makefile
WORKDIR /app/src
RUN make

# Switch back to the application root
WORKDIR /app

# Default command to test (i.e., run test.sh)
#CMD ["./vulnerable"]
CMD ["bash", "test.sh"]
