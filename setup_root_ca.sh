#!/bin/bash

# Root CA Directory Structure
mkdir -p demoCA/{private,certs,newcerts,crl}
touch demoCA/index.txt
echo 1000 > demoCA/serial

# Generate Root CA Private Key (AES-256 Encrypted)
openssl genrsa -aes256 -out demoCA/private/ca.key 4096

# Generate Self-Signed Root CA Certificate (Valid 10 Years)
openssl req -x509 -new -key demoCA/private/ca.key -days 3650 -out demoCA/ca.crt \
  -subj "/C=IN/ST=Uttar Pradesh/L=Prayagraj/O=MyOrg/CN=My Root CA"

chmod 700 demoCA
chmod 600 demoCA/private/ca.key
chmod 644 demoCA/ca.crt

echo "Root CA setup complete. Files: demoCA/private/ca.key, demoCA/ca.crt"

