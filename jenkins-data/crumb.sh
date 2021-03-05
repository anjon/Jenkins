#!/bin/bash
crumb=$(curl -u "jenkins:passw0rd" -s 'http://jenkins.local:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
#curl -u "jenkins:passw0rd" -H "$crumb" -X POST http://jenkins.local:8080/job/ENV/build?delay=0sec
curl -u "jenkins:passw0rd" -H "$crumb" -X POST  http://jenkins.local:8080/job/Ansible-Users-DB/buildWithParameters?AGE=35
