FROM vungle/java:8
MAINTAINER devops@vungle.com

ENV LOGSTASH_PKG_NAME logstash-5.6.2

# Install Logstash
RUN \
  ( curl -Lskj http://artifacts.elastic.co/downloads/logstash/$LOGSTASH_PKG_NAME.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv $LOGSTASH_PKG_NAME /logstash && \
  rm -rf $(find /logstash | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))")

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY config/ /logstash/config/


# Optional certificates folder
VOLUME ["/logstash/certs"]

ENTRYPOINT ["/run.sh"]
