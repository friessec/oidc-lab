#!/bin/bash

while [[ ! -e ${CA_DIR}/${VIRTUAL_HOST}/${VIRTUAL_HOST}.crt ]] ; do
    sleep 1
done

if [ ! -e /usr/local/share/ca-certificates/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/local/share/ca-certificates/${CA_CERT}
  update-ca-certificates
fi

export BASE_URI=https://${VIRTUAL_HOST}
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export FLASK_APP=oidc
export FLASK_ENV=development


python oidc.py &

nginx -g 'daemon off;'
