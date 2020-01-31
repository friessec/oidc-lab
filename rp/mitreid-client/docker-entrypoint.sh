#!/bin/bash

if [ ! -e /usr/local/share/ca-certificates/CA_CERT ]; then
  cp -f CA_DIR/CA_CERT /usr/local/share/ca-certificates/CA_CERT
  update-ca-certificates

  keytool -keystore /usr/local/openjdk-8/lib/security/cacerts -storepass changeit -noprompt -trustcacerts \
          -importcert -alias oidc -file /usr/share/ca-certificates/CA_CERT
fi

service apache2 start

su jboss -s /bin/bash -c "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"
