#!/bin/bash
echo "Create the intermediate pair
Prepare the directory
The root CA files are kept in /root/ca. Choose a different directory (/root/ca/intermediate) to store the intermediate CA files.
Press Enter to continue"
read
mkdir /root/ca/intermediate
echo "Create the same directory structure used for the root CA files.
Press Enter to continue"
read
cd /root/ca/intermediate
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
echo "Add a crlnumber file to the intermediate CA directory tree. crlnumber is used to keep track of certificate revocation lists.
Press Enter to continue"
read
echo 1000 > /root/ca/intermediate/crlnumber
echo "Copy the intermediate CA configuration file to /root/ca/intermediate/openssl.cnf. Five options have been changed compared to the root CA configuration file
Press Enter"
cp ~/Openssl/2.cnf /root/ca/intermediate/openssl.cnf
echo "Create the intermediate key (intermediate.key.pem). Encrypt the intermediate key with AES 256-bit encryption and a strong password.
Press Enter"
read
cd /root/ca
openssl genrsa -aes256 \
      -out intermediate/private/intermediate.key.pem 4096
echo "Change permission of intermediate.key.pem
Press Enter"
read
chmod 400 intermediate/private/intermediate.key.pem
echo "Use the intermediate key to create a certificate signing request (CSR). The details should generally match the root CA. The Common Name, however, must be different.
Press Enter"
read
cd /root/ca
openssl req -config intermediate/openssl.cnf -new -sha256 \
      -key intermediate/private/intermediate.key.pem \
      -out intermediate/csr/intermediate.csr.pem
echo "To create an intermediate certificate, use the root CA with the v3_intermediate_ca extension to sign the intermediate CSR. The intermediate certificate should be valid for a shorter period than the root certificate. Ten years would be reasonable.
Press Enter"
read
cd /root/ca
openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in intermediate/csr/intermediate.csr.pem \
      -out intermediate/certs/intermediate.cert.pem
echo "Change Permssions
Press Enter"
read
chmod 444 intermediate/certs/intermediate.cert.pem
echo "Verify the intermediate certificate
Press Enter"
openssl x509 -noout -text \
      -in intermediate/certs/intermediate.cert.pem
echo "Verify the intermediate certificate against the root certificate. An OK indicates that the chain of trust is intact.
Press Enter"
read
openssl verify -CAfile certs/ca.cert.pem \
      intermediate/certs/intermediate.cert.pem
echo "Create the certificate chain file

When an application (eg, a web browser) tries to verify a certificate signed by the intermediate CA, it must also verify the intermediate certificate against the root certificate. To complete the chain of trust, create a CA certificate chain to present to the application.
Press Enter"
read
cat intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem
echo "Change permissions"
chmod 444 intermediate/certs/ca-chain.cert.pem
echo "Finished Intermediate Pair"









