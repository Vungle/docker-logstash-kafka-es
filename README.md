
# docker-logstash-kafka-es
Lean (311MB) Logstash Docker image for shipping json logs from Kafka to ElasticSearch, based on `pires/docker-logstash`.

## Current software

* Oracle JRE 8 Update 74
* Logstash 2.2.0

## Run

Assuming:
* `/logstash/config` - where `logstash` will look for `logstash.conf` file
* `/logstash/certs` - where `logstash` will look for certificate files

Run:

```
docker run --name logstash \
  --detach \
  -e ZK_CONNECT_LIST=1.2.3.4,5.6.7.8 \
  -e KAFKA_TOPIC=as-requestAd \
  -e ES_URL=http://19.18.17.16/ \
  -e ES_INDEX=as-requestad \
  -e CODEC=magic \
  vungle/docker-logstash-kafka-es:2.2.0
```
