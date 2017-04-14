#!/bin/bash

if [ "`curl -s localhost:8080/plaintext`" != "Hello, world!" ]; then
  echo "Plaintext query failed." && exit 1
fi

if [ $(echo `curl -s localhost:8080/queries` | json -a | json -k -a | paste -d, -s) != $(echo randomNumber,id) ]; then
  echo "Queries query failed." && exit 1
fi

if [ $(echo `curl -s localhost:8080/update` | json -a | json -k -a | paste -d, -s) != $(echo randomnumber,id) ]; then
  echo "Update query failed." && exit 1
fi

if [ $(echo `curl -s localhost:8080/db` | json -k -a | paste -d, -s) != $(echo randomNumber,id) ]; then
  echo "Db query failed." && exit 1
fi

if [ $(curl -s -o /dev/null -w "%{http_code}"  localhost:8080/fortune) != "200" ]; then
  echo "Fortune query failed." && exit 1
fi

if [ $( curl -s localhost:8080/json | json -k -a | paste -d, -s) != $(echo "message") ]; then
  echo "Json query failed." && exit 1
fi