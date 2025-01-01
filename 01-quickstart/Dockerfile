# The Dockerfile for running the program using AFL-generated test cases.
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y build-essential bc

WORKDIR /app/
COPY src /app/

RUN make
#CMD ["./vulnerable"]
CMD ["bash", "test.sh"]
