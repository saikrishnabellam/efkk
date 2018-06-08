#!/bin/sh
/usr/share/elasticsearch/plugins/search-guard-5/tools/sgadmin.sh -cd /usr/share/elasticsearch/config/ -ts /usr/share/elasticsearch/config/truststore.jks -ks /usr/share/elasticsearch/config/kirk-keystore.jks -nhnv -icl
