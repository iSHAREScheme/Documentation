.. _refJWT:

iSHARE JWT
==========

A JSON Web Token (JWT) is used when non-repudiation between parties is required. A statement, of which the data is encoded in JSON, is digitally signed to protect the authenticity and integrity of the statement. iSHARE uses signed JWTs in the following ways:

* In a request for an OAuth Access Token or an OpenID Connect ID token the client sends a signed JWT. The client is authenticated based on the verification of the JWT's signature.
* Delegation evidence is presented as a signed JWT. The signature of the Authorization Registry or Entitled Party provides proof to other parties.
* In a response from a server iSHARE metadata is presented as a signed JWT. The signature is used to bind the iSHARE metadata (such as license information) in the JWT to the content of the response.
* A service from an iSHARE Service Provider MAY require a request to be signed.
* If there is potential that a JWT could be intercepted by intermediaries, JSON Web Encryption (JWE) may be used. This is explicitly used in Human2Machine interaction in the OpenID flow.

The following section describes the requirements for an iSHARE Signed JWT.

JWT Signing (JWS)
-----------------

All iSHARE JWTs MUST be signed using the JSON Web Signature (JWS) standard which can be found at `RFC 7515 <https://tools.ietf.org/html/rfc7515>`_.

JWT Header
----------

* Signed JWTs MUST use and specify the RS256 algorithm in the alg header parameter.
* Signed JWTs MUST contain an array of the complete certificate chain that should be used for validating the JWT's signature in the x5c header parameter up until an Issuing CA is listed from the iSHARE Trusted List.
* Certificates MUST be formatted as base64 encoded DER.
* The certificate of the client MUST be the first in the array, the root certificate MUST be the last.
* Except from the alg, typ and x5c parameter, the JWT header SHALL NOT contain other header parameters.

Example JWT Header:

.. code-block:: json

  {
    "alg": "RS256",
    "typ": "JWT",
    "x5c": ["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"]
  }

.. _refJWTPayload:

JWT Payload
-----------

* The JWT payload MUST conform to the private_key_jwt method as specified in `OpenID Connect 1.0 Chapter 9 <https://openid.net/specs/openid-connect-core-1_0.html#ClientAuthentication>`_.
* The JWT MUST always contain the iat claim.
* The iss and sub claims MUST contain the valid iSHARE identifier (EORI) of the client.
* The aud claim MUST contain only the valid iSHARE identifier of the server. Including multiple audiences creates a risk of impersonation and is therefore not allowed.
* The JWT MUST be set to expire in 30 seconds. The combination of iat and exp claims MUST reflect that. Both iat and exp MUST be in seconds, NOT milliseconds. See :ref:`UTC Time formatting<refUTC>` for requirements.
* The JWT MUST contain the jti claim for audit trail purposes. The jti is not necessary a GUID/UUID.
* Depending on the use of the JWT other JWT payload data MAY be defined.

In OAuth 2.0 clients are generally pre-registered. Since in iSHARE servers interact with clients that have been previously unknown this is not a workable requirement. Therefore iSHARE implements a generic client identification and authentication scheme, based on iSHARE whitelisted PKIs.

Since OAuth 2.0 doesn't specify a PKI based authentication scheme, but OpenID Connect 1.0 does, iSHARE chooses to use the scheme specified by OpenID Connect in all use cases. This is preferred above defining a new proprietary scheme.

Example JWT Payload:

.. code-block:: json

  {
    "iss": "EU.EORI.NL123456789",
    "sub": "EU.EORI.NL123456789",
    "aud": "EU.EORI.NL987654321",
    "jti": "378a47c4-2822-4ca5-a49a-7e5a1cc7ea59",
    "exp": 1504683475,
    "iat": 1504683445
  }


JWT Processing
--------------

* A server SHALL NOT accept a JWT more than once for authentication of the Client. However within it's time to live a Service Provider MAY forward a JWT from a Service Consumer to one or more other servers (Entitled Party or Authorization Registry) to obtain additional evidence on behalf of the Service Consumer. These other servers SHALL accept the JWT for indirect authentication of the Service Consumer during the JWT's complete time to live.
* A server SHALL only accept a forwarded JWT if the aud claim of the forwarded JWT matches the iss claim of the JWT from the client that forwards the JWT.
* JWT contents that are not specified within the iSHARE scope SHOULD be ignored.

.. _refJWE:

JSON Web Encryption (JWE)
-------------------------

JSON Web Encryption (JWE) is used to encrypt the JWS when there is the potential that a JWS could be intercepted by intermediaries. Since a JWS only encodes and signs information, it supports non-repudiation. It is assumed that communication within iSHARE is done over a TLS encrypted line (which is mandatory per the OAuth specification). In case of direct machine to machine use cases, this is secure enough to prevent interception between intermediaries.

In cases where the actual data transfer is done using some other transport protocol (other than HTTPS using TLS), an encoded JWS would not protect data from being read as long as it is intercepted in between. To make sure that such data in JWS is also secure and only the intended party can open it, we prescribe to use the JWE specification for encrypting JWS. The specification can be found at `RFC 7516 <https://tools.ietf.org/html/rfc7516>`_.

In human to machine cases using OpenID, the initial flow requires a Service Provider to send the request JWS to the User Agent for redirection to the Identity Provider. In such a case, a JWS can be easily intercepted and read by the user. Using JWE, the contents of the JWS can be encrypted in such a case. Apart from the case in the human to machine flow, when data is exchanged, it may be needed to be encrypted (aside from TLS) for various reasons. JWE could be used in those cases.

When Identity Brokers are used within iSHARE, it would be necessary to encrypt the JWS to make sure data is not unnecessarily readable by the Identity Broker.

JWE Header
----------

* JWEs MUST use and specify the "RSA-OAEP" asymmetric encryption algorithm in the alg header parameter.
* JWEs MUST use and specify the "A256GCM" symmetric encryption algorithm in the enc header parameter.
* Except from the alg, enc and typ parameter, the JWE header SHALL NOT contain other header parameters.

JWE Content
-----------

The content of the JWE is the plaintext that needs to be encrypted. For the use of JWE in iSHARE, this MUST be a signed JWS according to the specifications on this page.