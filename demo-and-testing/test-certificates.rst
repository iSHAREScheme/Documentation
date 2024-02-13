Test Certificates
=================

.. _refGetTestCert:

Get Test Certificate
--------------------

In order to get an iSHARE Test certificate, the iSHARE organization needs to have:

* Your company common name
* Your company country
* Your company EORI number (used as iSHARE identifier)

`Click here <https://ca7.isharetest.net:8442/ejbca/ra/index.xhtml>`_ to request your test certificate directly.

.. note:: Please note that test certificates should ONLY be used for testing purposes and to communicate test data. They are not reliable enough to be used for authentication outside of the test network, nor were they designed and distributed for that purpose. The iSHARE organisation provides the test certificates without warranty of any kind, and shall in no event or case be liable for any damage or liability in connection with the use of the test certificates.

iSHARE Test CA
--------------

iSHARE Test certificates are issued by the iSHARE Test Certificate Authority. Please download the certificates as they are needed to trust iSHARE Test certificates when interacting with the test environment.

In case your knowledge of certificates could use a quick refreshment, please refer to the iSHARE Certificate 'Cheat sheet'. This document gives a brief overview of common certificate types, how certificates are used within iSHARE and various OpenSSL commands for certificate conversion. Click :download:`here <./resources/certificates/181113iSHARE_Certificate_cheat_sheet_v1.pdf>` to download the cheat sheet.

* :download:`Various CA roots <https://ca7.isharetest.net:8442/ejbca/retrieve/ca_certs.jsp>`
