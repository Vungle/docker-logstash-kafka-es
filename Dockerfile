FROM quay.io/pires/docker-jre:8u74-dns
MAINTAINER devops@vungle.com

ENV LOGSTASH_PKG_NAME logstash-7.6.0

# Install Logstash
RUN apk add --update curl bash ca-certificates
RUN \
  ( curl -Lskj https://artifacts.elastic.co/downloads/logstash/$LOGSTASH_PKG_NAME.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv $LOGSTASH_PKG_NAME /logstash && \
  rm -rf $(find /logstash | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") && \
  apk del curl wget

COPY run.sh /run.sh
RUN chmod +x /run.sh
RUN rm -rf /logstash/config/logstash-sample.conf

COPY config/ /logstash/config/


# Optional certificates folder
VOLUME ["/logstash/certs"]

ENTRYPOINT ["/run.sh"]
