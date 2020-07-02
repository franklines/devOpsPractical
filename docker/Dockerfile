FROM node:14.4.0
LABEL maintainer="Franklin Escobar"
LABEL github="https://github.com/franklines/devOpsPractical"

RUN apt-get update && \
    apt-get install git -y

RUN mkdir -p /opt/swimlane

WORKDIR /opt/swimlane

RUN git clone https://github.com/swimlane/devops-practical.git

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["docker-entrypoint.sh"]

