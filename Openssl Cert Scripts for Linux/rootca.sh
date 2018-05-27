#!/bin/bash
echo "Press Enter to start." 
echo "Create the root pair

Acting as a certificate authority (CA) means dealing with cryptographic pairs of private keys and public certificates. The very first cryptographic pair we’ll create is the root pair. This consists of the root key (ca.key.pem) and root certificate (ca.cert.pem). This pair forms the identity of your CA.

Choosing directory /root/ca to store all keys and certificates.

Press Enter to continue."
read
mkdir /root/ca

echo "Creating the directory structure. The index.txt and serial files act as a flat file database to keep track of signed certificates.

Press Enter to continue."

read
cd /root/ca
echo "Make OpenSSL Directories under /root/ca
Press Enter to continue."
read
mkdir certs crl newcerts private
echo "Change permissions
Press Enter to continue."
read
chmod 700 private
touch index.txt
echo 1000 > serial
echo "Check the file system of root for 'ca.'
Press Enter to continue."
read
dir /root/
echo "Check the structure of /root/ca for 'certs, crl, index.txt, newcerts, private, and serial.'
Press Enter"
read
dir /root/ca
echo "Copy 'openssl.cnf' to '/root/ca/openssl.cnf'
You must create a configuration file for OpenSSL to use.
Press Enter to continue"
read
cp ~/Openssl/openssl.cnf /root/ca/openssl.cnf 
echo "Check '/root/ca/' for 'openssl.cnf'
Press Enter to continue"
read
dir /root/ca
echo "Create the root key (ca.key.pem) and keep it absolutely secure. Anyone in possession of the root key can issue trusted certificates. Encrypt the root key with AES 256-bit encryption and a strong password.
Press Enter to continue"
read
cd /root/ca
openssl genrsa -aes256 -out private/ca.key.pem 4096
echo "Change permissions for 'ca.key.pem;
Press Enter to continue"
chmod 400 /root/ca/private/ca.key.pem
echo "Create the root certificate

Use the root key (ca.key.pem) to create a root certificate (ca.cert.pem). Give the root certificate a long expiry date, such as twenty years. Once the root certificate expires, all certificates signed by the CA become invalid.
Press Enter"
read
openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem
echo "Change permissions for 'ca.cert.pem'
Press Enter"
read
chmod 444 certs/ca.cert.pem
echo "Verify the root certificate
Press Enter"
read
openssl x509 -noout -text -in certs/ca.cert.pem

echo "Finished with Root Certificate
Press Enter to exit"
read
exit
