#!/bin/bash
echo "The Online Certificate Status Protocol (OCSP) was created as an alternative to certificate revocation lists (CRLs). Similar to CRLs, OCSP enables a requesting party (eg, a web browser) to determine the revocation state of a certificate.
Press Enter to continue"
read
echo "When a CA signs a certificate, they will typically include an OCSP server address (eg, http://ocsp.example.com) in the certificate. This is similar in function to crlDistributionPoints used for CRLs.
Press Enter to continue"
read
echo "As an example, when a web browser is presented with a server certificate, it will send a query to the OCSP server address specified in the certificate. At this address, an OCSP responder listens to queries and responds with the revocation status of the certificate.
Press Enter to continue"
read
echo "Create the OCSP pair
The OCSP responder requires a cryptographic pair for signing the response that it sends to the requesting party. The OCSP cryptographic pair must be signed by the same CA that signed the certificate being checked.
Press Enter"
read
echo "Create a private key and encrypt it with AES-256 encryption.
Press Enter"
read
cd /root/ca
openssl genrsa -aes256 \
      -out intermediate/private/ocsp.example.com.key.pem 4096
echo "Create a certificate signing request (CSR). The details should generally match those of the signing CA. The Common Name, however, must be a fully qualified domain name.
Press Enter"
read
cd /root/ca
openssl req -config intermediate/openssl.cnf -new -sha256 \
      -key intermediate/private/ocsp.example.com.key.pem \
      -out intermediate/csr/ocsp.example.com.csr.pem
echo "Sign the CSR with the intermediate CA.
Press Enter"
read
openssl ca -config intermediate/openssl.cnf \
      -extensions ocsp -days 375 -notext -md sha256 \
      -in intermediate/csr/ocsp.example.com.csr.pem \
      -out intermediate/certs/ocsp.example.com.cert.pem
echo "Verify that the certificate has the correct X509v3 extensions.
Press Enter"
read
openssl x509 -noout -text \
      -in intermediate/certs/ocsp.example.com.cert.pem

    X509v3 Key Usage: critical
        Digital Signature
    X509v3 Extended Key Usage: critical
        OCSP Signing
echo "Finished OSCP
Press Enter to exit"
read










