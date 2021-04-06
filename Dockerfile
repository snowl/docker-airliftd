FROM debian:jessie-slim

LABEL maintainer="airlift test"

ENV AIRLIFT_VERSION 0.4.1
ENV PKG_RELEASE O

#RUN groupadd -r airliftd && useradd -r -g airliftd airliftd

RUN groupadd -g 9000 airliftd && useradd -r -u 9000 -g airliftd airliftd

RUN apt-get update && apt-get -y install curl \
    && curl -L -o /tmp/airliftd-v0.4.1-linux_amd64.tar.gz https://github.com/moshee/airlift/releases/download/v0.4.1/airliftd-v0.4.1-linux_amd64.tar.gz \
    && ls /tmp \
    && tar xvzf /tmp/airliftd-v0.4.1-linux_amd64.tar.gz --directory /opt \
    && ls /opt/*


EXPOSE 60606

STOPSIGNAL SIGTERM

USER airliftd

CMD ["/opt/airliftd"]
