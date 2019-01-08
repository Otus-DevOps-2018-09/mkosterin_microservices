#!/bin/bash
gcloud compute firewall-rules create fluentd --allow tcp:24224
gcloud compute firewall-rules create fluentd-udp --allow udp:24224
gcloud compute firewall-rules create elasticsearch --allow tcp:9200
gcloud compute firewall-rules create kibana --allow tcp:5601
gcloud compute firewall-rules create kibana --allow tcp:9411



