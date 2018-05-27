#!/bin/bash
echo "A certificate revocation list (CRL) provides a list of certificates that have been revoked. A client application, such as a web browser, can use a CRL to check a server’s authenticity. A server application, such as Apache or OpenVPN, can use a CRL to deny access to clients that are no longer trusted.
Press Enter to continue"
read
echo "Publish the CRL at a publicly accessible location (eg, http://example.com/intermediate.crl.pem). Third-parties can fetch the CRL from this location to check whether any certificates they rely on have been revoked.
Press Enter to continue"
read
echo "Some applications vendors have deprecated CRLs and are instead using the Online Certificate Status Protocol (OCSP).
Press Enter to continue"
read

echo "Create the CRL
Press Enter"
read
cd /root/ca
openssl ca -config intermediate/openssl.cnf \
      -gencrl -out intermediate/crl/intermediate.crl.pem
echo "You can check the contents of the CRL with the crl tool.
Press Enter"
read
openssl crl -in intermediate/crl/intermediate.crl.pem -noout -text
echo "No certificates have been revoked yet, so the output will state No Revoked Certificates.
Finished creating the crl.
Press Enter to exit"
read





