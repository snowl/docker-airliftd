FROM debian:bullseye-slim

LABEL maintainer="snowl"

ENV UID 1000
ENV GID 998
ENV AIRLIFT_VERSION v0.4.1
ENV PKG_RELEASE O

RUN set -x \
    && addgroup --system --gid ${GID} airliftd \
    && adduser --system --disabled-login --ingroup airliftd --gecos "airliftd user" --shell /bin/bash --uid ${UID} airliftd

RUN apt-get update && apt-get -y install curl \
    && curl -L -o /tmp/airliftd-${AIRLIFT_VERSION}-linux_amd64.tar.gz https://github.com/moshee/airlift/releases/download/${AIRLIFT_VERSION}/airliftd-${AIRLIFT_VERSION}-linux_amd64.tar.gz \
    && ls /tmp \
    && tar xvzf /tmp/airliftd-${AIRLIFT_VERSION}-linux_amd64.tar.gz --directory /opt \
    && ls /opt/*


EXPOSE 60606

STOPSIGNAL SIGTERM

USER airliftd

CMD ["/opt/airliftd"]
