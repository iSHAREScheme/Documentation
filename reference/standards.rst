.. _refStandards:

Technical Standards
===================

iSHARE can be described as an API architecture, which enables all parties involved to engage in direct communication. For interoperability reasons, iSHARE makes use of widely used open standards. Modified implementations of OAuth 2.0 and OpenID Connect 1.0 are used to facilitate an ecosystem in which parties can interact with previously unknown parties. Pre-registration, therefore, is not a prerequisite and this requires alterations to the official standards. Also, for the authentication of parties within an iSHARE context, iSHARE uses PKI and digital certificates relating to all participating parties.

API
---

An API (Application Programming Interface) is a technical interface, consisting of a set of protocols and data structuring standards ('API specifications') which enables computer systems to directly communicate with each other. Data or services can be directly requested from a server by adhering to the protocols. APIs are used to hide the full complexity of software and make it easy for third parties to use parts of software or data services. APIs are mainly meant for developers to make the creation of new applications depending on other applications easier.

APIs are used in iSHARE to facilitate direct and realtime communication between different parties, eliminating the need for a central platform. iSHARE APIs are designed to be RESTful, and JSON is used for structuring data. iSHARE prescribes caching requirements relating to the use of APIs in various situations.

Caching
-------

Caching is a way to boost performance efficiency. Often data is temporarily stored on a different medium, to enable faster access to the data.

For every API exposed under iSHARE caching MUST Be made explicit to the API consumer.

If a response is not cacheable it MUST contain the following headers:

::

    Cache-Control: no-store
    Pragma: no-cache

If a response is cacheable it MUST contain the following headers:

::

    Cache-Control: max-age=31536000
    Note: max-age MAY vary


HTTP(S)
-------

HyperText Transfer Protocol (Secure) is a communication protocol. iSHARE Scheme communication MUST be carried out over the HTTP protocol, and secured through TLS 1.2 resulting in HTTPS.

iSHARE authentication/authorisation data is generally transferred in HTTP Headers. These headers can become very large when containing multiple encrypted certificates or JWT's. iSHARE parties SHOULD configure their web servers to accept HTTP headers of larger sizes (usually 10K or more) to minimise implementation impact on current services.

The most recent version of the HTTP specification can be found at `w3.org <https://www.w3.org/Protocols/>`_.

After sending a HTTP request to a server, the server responds with (among others) a Status Code which indicates the outcome of the request made to the server.

+----------+-------------+-------------------------------------+---------------------------------------------+
| | HTTP   | | CRUD      | | Entire Collection (e.g. /parties) | | Specific Item (e.g. /parties/{id})        |
| | verb   |             |                                     |                                             |
+==========+=============+=====================================+=============================================+
| | POST   | | Create    | | 201 (Created), 'Location' header  | | 404 (Not Found),                          |
|          |             | | with link to /customers/{id}      | | 409 (Conflict) if resource already exists.|
|          |             | | containing new ID.                |                                             |
+----------+-------------+-------------------------------------+---------------------------------------------+
| | GET    | | Read      | | 200 (OK), list of customers. Use  | | 200 (OK), single customer.                |
|          |             | | pagination, sorting and filtering | | 404 (Not Found) if not found or invalid.  |
|          |             | | to navigate big lists.            |                                             |
+----------+-------------+-------------------------------------+---------------------------------------------+
| | PUT    | | Update    | | 404 (Not Found), unless you want  | | 200 (OK) or 204 (No Content).             |
|          | | Replace   | | to update/replace every resource  | | 404 (Not Found) if not found or invalid.  |
|          |             | | in the entire collection.         |                                             |
+----------+-------------+-------------------------------------+---------------------------------------------+
| | PATCH  | | Update    | | 404 (Not Found), unless you want  | | 200 (OK) or 204 (No Content).             |
|          | | Modify    | | to modify the collection itself.  | | 404 (Not Found) if not found or invalid.  |
|          |             |                                     |                                             |
+----------+-------------+-------------------------------------+---------------------------------------------+
| | DELETE | | Delete    | | 404 (Not Found), unless you want  | | 200 (OK).                                 |
|          |             | | to delete the whole collection,   | | 404 (Not Found) if not found or invalid.  |
|          |             | | not often desirable.              |                                             |
+----------+-------------+-------------------------------------+---------------------------------------------+


JSON
----

JSON (JavaScript Object Notation) is a data formatting standard. JSON is an open standard data format that does not depend on a specific programming language. This compact data format makes use of human-readable (easy to read) text to exchange data objects (structured data) between applications and for data storage.

Within iSHARE, JSON is used as data structuring standard for scheme related communication. For the most recent version of the JSON specification visit `json.org <https://www.json.org/json-en.html>`_.

JWT
---

JWT (JSON Web Token) is an open standard that defines a compact and self-contained way for securely transmitting information between parties as a JSON object. This information can be verified and trusted because it is digitally signed. Because of its size, it can be sent through an URL, POST parameter, or inside an HTTP header. Additionally, due to its size its transmission is fast.

A JWT is used in iSHARE when exchanging claims between parties. These claims are signed using the JSON Web Signature (JWS) standard to ensure non-repudiation of these claims. :ref:`JWT section<refJWT>` describes how iSHARE uses JWTs and what the specifications for iSHARE JWTs are, while the official standard can be found at `tools.ietf.org (RFC 7519) <https://tools.ietf.org/html/rfc7519>`_.

OAuth 2.0
---------

OAuth is a widely used security standard that enables secure access to protected resources in a fashion that is friendly to web APIs. It is a delegation protocol that provides authorization across systems. OAuth is about *how to get a token* and *how to use a token*. OAuth replaces the password-sharing antipattern with a deleagtion protocol that's simultaneosly more secure and more usable. OAuth focused on solving a small set of problems and solving them well, whch makes it a suitable component within larger security systems.

iSHARE uses the OAuth 2.0 protocol for authenticating parties and providing access tokens when requesting access to a service within iSHARE. For the most recent version of the OAuth 2.0 specification visit `oauth.net <https://oauth.net/2/>`_.

OpenID Connect 1.0
------------------

OpenID Connect is a simple identity layer on top of the OAuth 2.0 protocol specific for human subjects. It is used to obtain identity information for a human subject. Besides authenticating a human subject, the OpenID Connect flow can also be used to communicate information of the human subject to a server. For more information please read `official OpenID Connect specification <https://openid.net/specs/openid-connect-core-1_0.html>`_.

Just as in OAuth 2.0, iSHARE deviates from the original standard to allow for information exchange with previously unknown parties. Identity Providers need to provide API access to iSHARE participants based on whitelisted PKI, clients need not to be pre-registered at an Identity Provider.

PKI
---

A PKI (Public Key Infrastructure) is a system for distribution and management of digital keys and certificates, which enables secure authentication of parties interacting with each other. Generally, three different methods exist for creating trust within PKI's. These are through 'Certificate Authorities', 'Web of Trust' and 'Simple PKI'. Within iSHARE the *Certificate Authority* approach is used, and as such the other methods will not be discussed. A PKI can be considered as a chain of certificates. At the beginning of the chain is the root *Certificate Authority* (CA), a public trusted party which is allowed to digitally sign their own certificates (SSC, self-signed certificate). This *Root CA* distributes certificates and encryption keys to organisations. The certificate is signed by the *root CA* as proof that the owner of the certificate is trusted. These organisations can start issuing certificates as well, if allowed by their root. They become CA, and as such sign the certificates that they issue. Repeating these steps, a chain of certificates is created, with each certificate signed by the CA who issued the certificate. Parties need to trust a certificate for authentication purposes. Instead of trusting individual certificates of organisations, root certificates can be trusted. By trusting a root, all certificates that have the root within their PKI chains are automatically trusted. Most large root CA's are automatically trusted within web browsers, enabling computers to safely interact with most web servers.

For authentication purposes, iSHARE requires adhering and Certified Parties to acquire an X.509 certificate which is distributed by a trusted root under certain PKIs (Public Key Infrastructure). For interoperability on a European scale, all trusted roots under the eIDAS regulation will be trusted within iSHARE. Furthermore, iSHARE accepts certificates issued under PKIoverheid.

The eIDAS regulation aims to provide secure and seamless electronic interactions between businesses, citizens and public authorities throughout the entire EU. A main part of this regulation is that each EU country is required to establish and maintain *trusted lists*, among which trusted root information is found. Each EU country is required to implement these trusted lists in their own countries. Therefore, iSHARE aims to make use of these trusted lists as trust roots within iSHARE to ensure secure and seamless interaction throughout the EU.

RESTful
-------

Representational State Transfer (REST) is an architectural style for building systems and services, systems adhering to this architectural style are commonly referred to as *RESTful systems*. REST itself is not a formal standard, but it is an architecture that applies various common technical standards such as HTTP, JSON and URI. RESTful systems are able to process common HTTP operations, such as GET, POST and DELETE.

Within iSHARE RESTful architectural principles MUST be applied to the APIs that are specified. A RESTful API indicates that the API architecture follows REST *constraints*. Constraints restrict the way that servers respond and process client requests, in order to preserve the design goals which are intended by applying REST. Goals of REST are, among others, performance and scalability. Both are of utmost importance in iSHARE.

TLS
---

Transport Layer Security (TLS) is a cryptographic protocol that describes communication security for computer networks. It is used to secure the HTTP protocol, resulting in HTTPS.

Within iSHARE, TLS versions up to end of life MUST be used for securing all HTTP communications. Currently this means TLS 1.2 or 1.3. For the most recent version of the specification read `RFC 5246 <https://tools.ietf.org/html/rfc5246>`_.

.. _refUTC:

UTC
---

The UNIX timestamp is a way to track time as a running total of seconds. This count starts at the UNIX Epoch on January 1st, 1970 at UTC. Therefore, the UNIX time stamp is merely the number of seconds between a particular date and the UNIX Epoch. For example, on 7:34 PM (UTC) on the 4th of September 2018, 1536089675 seconds have passed since January 1st, 1970 at UTC. The UNIX formatted timestamp is therefore 1536089675. This Unix formatting of UTC point in time technically does not change no matter where you are located on the globe. This is very useful to computer systems for tracking and sorting dated information in dynamic and distributed applications both online and client side.

In iSHARE all dates and times MUST be communicated in UTC time. All dates and times MUST be formatted in the Unix timestamp format.

XACML 3.0
---------

XACML (eXtensible Access Control Markup Language) is an XML-based specification that is designed to control access to applications. One of the main advantages of this specification is that applications and systems with their own and different authorization structure can be integrated into one authorization scheme. authorization and the rules surrounding it can be managed centrally regardless of authorization mechanism of the applications themselves. This phenomenon is called externalisation. XACML is derived from SAML and provides the underlying specification for ABAC (Attribute-Based Access Control). XACML is also suitable to be used in combination with RBAC (Role-Based Access Control).
                  
Moreover, with the help of XACML authorization can be arranged and managed in detail. This is called fine-grained authorization . XACML supports the use of security labels, rules with arbitrary attributes, rules with a certain duration and dynamic rules.

In XACML two main functions can be distinguished. One function defines the criteria with which authorization are assigned, such as 'only an experienced user from department X is allowed to modify documents’. The other function compares the criteria with the rules or policies to determine whether a person is allowed to perform the operation on the object or not.

The architecture of XACML is fairly complex. This is partly due to the fact that it is difficult to fit the various components of XACML in the application landscape. These components should be positioned in such a way that the owner of the data can somehow control the authorization to his or her data, but at the same time the components should be positioned in such a way that the performance is not negatively influenced. This is extra important when independent parties need to cooperate with each other and want to jointly organise the access to their applications. Finally, applications need to be compatible with XACML.

XML-based standard for defining authorisation policies. Within iSHARE, a JSON port of XACML 3.0 is used to enable parties to communicate delegation evidence. Visit `docs.oasis-open.org <http://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html>`_ for the most recent version of this specification.

X.509
-----

In cryptography, X.509 is a standard defining the format of public key certificates. X.509 certificates are used in many Internet protocols, including TLS/SSL, which is the basis for HTTPS, the secure protocol for browsing the web. They are also used in offline applications, like electronic signatures. An X.509 certificate contains a public key and an identity (a hostname, or an organization, or an individual), and is either signed by a certificate authority or self-signed. When a certificate is signed by a trusted certificate authority, or validated by other means, someone holding that certificate can rely on the public key it contains to establish secure communications with another party, or validate documents digitally signed by the corresponding private key. 
The most recent version of this specification can be found at `tools.ietf.org (RFC 5280) <https://tools.ietf.org/html/rfc5280>`_.

X.509 is used in iSHARE as a standard defining the format of public key certificates.