#!/bin/bash -e

# Map environment variables to entries in logstash.yml.
# Note that this will mutate logstash.yml in place if any such settings are found.
# This may be undesirable, especially if logstash.yml is bind-mounted from the
# host system.	
export LS_JAVA_OPTS="-Dls.cgroup.cpuacct.path.override=/ -Dls.cgroup.cpu.path.override=/ $LS_JAVA_OPTS"

cat /logstash/config/logstash.conf

if [[ -z $1 ]] || [[ ${1:0:1} == '-' ]] ; then
  exec /logstash/bin/logstash "$@"
else
  exec "$@"
fi