#!/bin/bash
echo "Sign server and client certificates

We will be signing certificates using our intermediate CA. You can use these signed certificates in a variety of situations, such as to secure connections to a web server or to authenticate clients connecting to a service.

Create a key
Press Enter"
read
cd /root/ca 
openssl genrsa -aes256 \
      -out intermediate/private/www.example.com.key.pem 2048
chmod 400 intermediate/private/www.example.com.key.pem
echo "Create a certificate
Use the private key to create a certificate signing request (CSR). The CSR details don’t need to match the intermediate CA. For server certificates, the Common Name must be a fully qualified domain name (eg, www.example.com), whereas for client certificates it can be any unique identifier (eg, an e-mail address). Note that the Common Name cannot be the same as either your root or intermediate certificate.
Press Enter"
read
cd /root/ca
openssl req -config intermediate/openssl.cnf \
      -key intermediate/private/www.example.com.key.pem \
      -new -sha256 -out intermediate/csr/www.example.com.csr.pem
echo "To create a certificate, use the intermediate CA to sign the CSR. If the certificate is going to be used on a server, use the server_cert extension. If the certificate is going to be used for user authentication, use the usr_cert extension. Certificates are usually given a validity of one year, though a CA will typically give a few days extra for convenience.
Press Enter"
read
cd /root/ca
openssl ca -config intermediate/openssl.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in intermediate/csr/www.example.com.csr.pem \
      -out intermediate/certs/www.example.com.cert.pem
chmod 444 intermediate/certs/www.example.com.cert.pem
echo "Verify the certificate
Press Enter"
read
openssl x509 -noout -text \
      -in intermediate/certs/www.example.com.cert.pem
echo "Use the CA certificate chain file we created earlier (ca-chain.cert.pem) to verify that the new certificate has a valid chain of trust.
Press Enter"
read
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem \
      intermediate/certs/www.example.com.cert.pem
echo "Finished.
You can now either deploy your new certificate to a server, or distribute the certificate to a client. When deploying to a server application (eg, Apache), you need to make the following files available:

    ca-chain.cert.pem
    www.example.com.key.pem
    www.example.com.cert.pem

Press Enter to exit"
read





