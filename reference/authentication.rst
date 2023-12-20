.. _refAuthentication:

Authentication
==============


.. _refM2MAuthentication:

Machine to Machine (M2M) Authentication
=======================================

iSHARE refers to the OAuth 2.0 protocol for authenticating parties and providing access tokens based on the iSHARE agreements when requesting access to a iSHARE complaint service. For the most recent version of the OAuth 2.0 specification visit `oauth.net <https://oauth.net/2/>`_. In addition or overriding to the OAuth 2.0 specifications, the following requirements apply for iSHARE:

* Clients MUST NOT be pre registered. A look-up in the iSHARE adherence registry (satellite) is sufficient. It is up to the server to create a new entry for Clients that perform requests for the first time.
* The client_id MUST contain the valid iSHARE identifier of the client.
* In case of potential HTTP message size restrictions on the server, a POST call alternative MUST be offered to the /oauth2.0/token endpoint. Therefore, to avoid unaccepted HTTP GET calls, HTTP GET calls MUST be disabled to the /oauth2.0/token endpoint. 
* Servers MUST NOT issue refresh tokens

In OAuth 2.0 clients are generally pre-registered. Since in iSHARE, servers interact with clients that have been previously unknown this is not a workable requirement. Therefore this spec implements a client identification and authentication scheme, which allows participants to still establish the connection with each other based on the claims about themselves which are digitally signed with a PKI certificate which are trusted in the iSHARE scheme and thereby trusted by its members.

.. note:: M2M Interaction sections explain how authentication and authorization happens between participants of iSHARE. Authentication part requires a proper ``/token`` endpoint implementation. If you are already familiar how authentication works within iSHARE and ready to implement the endpoint, please visit :ref:`access token section<refM2MToken>`.

.. _refM2MTokenFlow:

Generic Authentication Flow
---------------------------

Based on the described standards and specifications in this scheme, the generic iSHARE Authentication flow is described in the following sequence diagram.

For a deeper understanding of the various roles within the iSHARE Trust network, take a look at the `framework and roles page <https://framework.ishare.eu/is/framework-and-roles>`_ in the official iSHARE Scheme of agreements.

.. image:: m2m/resources/180913M2MAuthenticationv1.7.png

The sequence diagram refers to Service Consumer, Service Provider and iSHARE Satellite. Please note that this Authentication flow applies to various possible interactions. Each party that needs to authenticate another party requesting data or services can be authenticated through this flow.
                  
In the demo section you can find :ref:`Postman Collections<refPostman>` that demo this authentication flow from the perspective of a Service Provider.

In :download:`this flow chart <m2m/resources/190501D_Access_token_validation.pdf>`, we describe the steps within the authentication flow in greater detail.

.. _refCertificateValidation:

Certificate Validation
----------------------

Validating the certicate mainly consists of two steps:

1. Verifying the validity of the certificate (steps 2.2.2 and 2.2.3 of the above generic authentication flow).
2. Verifying the iSHARE Status of the party (step 2.2.6 of the above generic authentication flow).

It is always the responsibility of the receiving iSHARE Party to verify the certificate and the status of the requesting iSHARE Party! During conformance testing (see :ref:`Conformance Test Tool<refCTT>`) we can only test how you validate test-certificates. It is important to make sure that real certificates are validated in a proper way, as described below.

**1. Verifying the validity of the certificate**

A request in iSHARE must always be signed by a certificate that is issued by a certificate authority on the trusted list of iSHARE. Participants can get the trusted list via the /trusted_list endpoint. The trusted list consists of certificate authorities of the qualified Trust Service Providers. The party receiving the request signed by such a certificate is responsible for verifying that the certificate is issued by a certificate authority on the trusted list.

**2. Verifying the iSHARE Status**

Within iSHARE, it is necessary to match the identity on the certificate that is used to sign the client_assertion with the party identifier (EORI) within that client_assertion. It is possible that the EORI is not recorded on the certificate. Therefore, the standard procedure to verify the status of an iSHARE Party is as follows:

1. Authenticate yourself with the iSHARE Satellite at the /token endpoint.
2. Send a request to the :ref:`/parties endpoint<refParties>` of the iSHARE Satellite. Parameter ``eori`` value should be ``client_id`` from request (it should be equal to ``iss`` or ``sub`` in ``client_assertion``). 
3. Decode the parties_token received and check the signature.
4. In the information, the status of the party is listed under "status" and should be equal to "Active". The ``x5c`` value or ``x5t#s256`` of the certificate can be compared with the certificate which has signed the client assertion in the request. 

.. note:: The old method of validating participant using the certificate subject name is highly discouraged as in practice that method was quite unreliable. In any case the party validating token request (client_assertion) is responsible for proper validation of the incoming requests and with the whole certificate provided in the parties_token must be used for that purposes. This specifications can only provide guidance about it.

----

**Example of iSHARE status verification of ABC Trucking:**

1. The ``x5c`` value of ABC Trucking's request:

::

    MIID2jCCAsKgAwIBAgIINqe/ESZKbs0wDQYJKoZIhvcNAQELBQAwPDE6MDgGA1UEAwwxVEVTVCBpU0hBUkUgRVUgSXNzdWluZyBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBHNTAeFw0yMzAyMjQxNjUwMzVaFw0zMzAyMjExNjUwMzRaMGYxFTATBgNVBAMMDEFCQyBUcnVja2luZzEcMBoGA1UEBRMTRVUuRU9SSS5OTDAwMDAwMDAwMTENMAsGA1UECwwEVGVzdDETMBEGA1UECgwKaVNIQVJFVGVzdDELMAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTvswK5QL7yCgkp9bix2l4gpFkRHP+aoeD25FsCKnXUbpHW/QAi6/dOPGh6PFXTaL4QrdcPQIcokxUcGJgWF8rSQkdFpXDaRs1bG6CVw/nSkROoonbdAMGh+UCV6wOzuxDCaUysYh0MMsXKrv4lJ0Ah1ST6oCMnoTCUOTuqLUg/V/84XdDN1KjR67png+YZwpl22/skdPO6FE6mL23aLBz/AOs5nfiMeP+FJfklxoCgDGv9hE7bRhKBCIQqgXaikwoBxZF2Fp92qe/K0c/Sx/Q3Tkcve8a6gJIAoSpiKRjSlPoYmwLN76bK43BDUiU1OtJrvMZw+rNUC1IUSexOGTLAgMBAAGjgbUwgbIwHwYDVR0jBBgwFoAUbcVlicvfkVTRazy3AqUuzYpokB0wJwYDVR0lBCAwHgYIKwYBBQUHAwIGCCsGAQUFBwMEBggrBgEFBQcDATA3BggrBgEFBQcBAwQrMCkwCAYGBACORgEBMAgGBgQAjkYBBDATBgYEAI5GAQYwCQYHBACORgEGAjAdBgNVHQ4EFgQU6h8u1iZphlReD4SxckZeN3cA4SYwDgYDVR0PAQH/BAQDAgbAMA0GCSqGSIb3DQEBCwUAA4IBAQBY+5XE8N0Im+PWctdtwr5452B92gcszx/TapVbOoW4+mGLtKqDwkh/xRJN+5wFjGVlhg2W9ROEpuUcWGlbx+48wQ3OBWGXpdVeDvKaOA9KH2wDagn/A1TIiBR7MSwnFNS6CVus/khnCaMsdYl6OYItiUP8xF6YHAmtY/iT3RAzzVL+ZrOIYB66rp20O19sERlbURiFk34eF6LA78R8FACNgEuGNrmgkh7hl7Gt5Kgsylio6Smz3m5WAeqdhkY5BVn+a6wxzO7uRtZRHjhFPI7leOKd4EcLZ7UaByaU4aCxowiM+K6e/dovPZyBvXkVPV4UJOLxPg2DJT2evbzA31Ul

2. The call to ``/parties`` endpoint to verify the iSHARE status:

::

    GET /parties?
        eori=EU.EORI.NL000000001

(URL encoding removed, and line breaks added for readability)

3. The decoded response lists ABC Trucking as "Active" and includes certificate x5c and x5t#s256 values of the certificate used during registration. One of these certificates should be matching the certificate used for signing the JWT (client assertion):

.. code-block:: json

  {
    "party_info": {
        "party_id": "EU.EORI.NL000000001",
        "party_name": "ABC Trucking",
        "capability_url": "",
        "registrar_id": "EU.EORI.NL000000000",
        "adherence": {
            "status": "Active",
            "start_date": "2023-01-31T00:00:00.000Z",
            "end_date": "2024-02-01T00:00:00.000Z"
        },
        "additional_info": {
            "description": "",
            "logo": "",
            "website": "",
            "company_phone": "",
            "company_email": "",
            "publicly_publishable": "false",
            "countriesOfOperation": [],
            "sectorIndustry": [],
            "tags": ""
        },
        "agreements": [
            {
                "type": "TermsOfUse",
                "title": "Terms of use",
                "status": "Accepted",
                "sign_date": "2023-01-31T00:00:00.000Z",
                "expiry_date": "2024-01-31T00:00:00.000Z",
                "hash_file": "614331b0003219f2d2d123b0cd6105fb",
                "framework": "iSHARE",
                "dataspace_id": "",
                "dataspace_title": "",
                "complaiancy_verified": "yes"
            },
            {
                "type": "AccessionAgreement",
                "title": "Accession agreement",
                "status": "Accepted",
                "sign_date": "2023-01-31T00:00:00.000Z",
                "expiry_date": "2024-01-31T00:00:00.000Z",
                "hash_file": "f50a036402b3b243910ce572930be9f5",
                "framework": "iSHARE",
                "dataspace_id": "",
                "dataspace_title": "",
                "complaiancy_verified": "yes"
            }
        ],
        "certificates": [
            {
                "subject_name": "CN=ABC Trucking,SERIALNUMBER=EU.EORI.NL000000001,OU=Test,O=iSHARETest,C=NL",
                "certificate_type": "PKIo",
                "enabled_from": "2023-12-20T00:00:00.000Z",
                "x5c": "MIID2jCCAsKgAwIBAgIINqe/ESZKbs0wDQYJKoZIhvcNAQELBQAwPDE6MDgGA1UEAwwxVEVTVCBpU0hBUkUgRVUgSXNzdWluZyBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBHNTAeFw0yMzAyMjQxNjUwMzVaFw0zMzAyMjExNjUwMzRaMGYxFTATBgNVBAMMDEFCQyBUcnVja2luZzEcMBoGA1UEBRMTRVUuRU9SSS5OTDAwMDAwMDAwMTENMAsGA1UECwwEVGVzdDETMBEGA1UECgwKaVNIQVJFVGVzdDELMAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTvswK5QL7yCgkp9bix2l4gpFkRHP+aoeD25FsCKnXUbpHW/QAi6/dOPGh6PFXTaL4QrdcPQIcokxUcGJgWF8rSQkdFpXDaRs1bG6CVw/nSkROoonbdAMGh+UCV6wOzuxDCaUysYh0MMsXKrv4lJ0Ah1ST6oCMnoTCUOTuqLUg/V/84XdDN1KjR67png+YZwpl22/skdPO6FE6mL23aLBz/AOs5nfiMeP+FJfklxoCgDGv9hE7bRhKBCIQqgXaikwoBxZF2Fp92qe/K0c/Sx/Q3Tkcve8a6gJIAoSpiKRjSlPoYmwLN76bK43BDUiU1OtJrvMZw+rNUC1IUSexOGTLAgMBAAGjgbUwgbIwHwYDVR0jBBgwFoAUbcVlicvfkVTRazy3AqUuzYpokB0wJwYDVR0lBCAwHgYIKwYBBQUHAwIGCCsGAQUFBwMEBggrBgEFBQcDATA3BggrBgEFBQcBAwQrMCkwCAYGBACORgEBMAgGBgQAjkYBBDATBgYEAI5GAQYwCQYHBACORgEGAjAdBgNVHQ4EFgQU6h8u1iZphlReD4SxckZeN3cA4SYwDgYDVR0PAQH/BAQDAgbAMA0GCSqGSIb3DQEBCwUAA4IBAQBY+5XE8N0Im+PWctdtwr5452B92gcszx/TapVbOoW4+mGLtKqDwkh/xRJN+5wFjGVlhg2W9ROEpuUcWGlbx+48wQ3OBWGXpdVeDvKaOA9KH2wDagn/A1TIiBR7MSwnFNS6CVus/khnCaMsdYl6OYItiUP8xF6YHAmtY/iT3RAzzVL+ZrOIYB66rp20O19sERlbURiFk34eF6LA78R8FACNgEuGNrmgkh7hl7Gt5Kgsylio6Smz3m5WAeqdhkY5BVn+a6wxzO7uRtZRHjhFPI7leOKd4EcLZ7UaByaU4aCxowiM+K6e/dovPZyBvXkVPV4UJOLxPg2DJT2evbzA31Ul",
                "x5t#s256": "778e88582bc15a1a11393f17db5e86898a8455e3e38762b63101f8e3b892c683"
            }
        ],
        "roles": [
            {
                "role": "ServiceConsumer",
                "start_date": "2023-01-31T00:00:00.000Z",
                "end_date": "2024-01-31T00:00:00.000Z",
                "loa": "High",
                "complaiancy_verified": "yes",
                "legal_adherence": "yes"
            },
            {
                "role": "ServiceProvider",
                "start_date": "2023-01-31T00:00:00.000Z",
                "end_date": "2024-01-31T00:00:00.000Z",
                "loa": "High",
                "complaiancy_verified": "yes",
                "legal_adherence": "yes"
            },
            {
                "role": "EntitledParty",
                "start_date": "2023-01-31T00:00:00.000Z",
                "end_date": "2024-01-31T00:00:00.000Z",
                "loa": "High",
                "complaiancy_verified": "yes",
                "legal_adherence": "yes"
            }
        ],
        "authregistery": []
    }
  }


.. _refH2MAuthentication:

Human to Machine (H2M) Authentication
=====================================

Besides Machine2Machine interaction, it can occur that it is relevant if a specific person requests data or a service. In order to provide a Service Provider with identity information about a human subject, iSHARE refers to the OpenID Connect 1.0 protocol.

The iSHARE use of OpenID Connect 1.0 is based on the requirements from the `official standard <https://openid.net/specs/openid-connect-core-1_0.html>`_. In addition to the OpenID Connect 1.0 specification, the following requirements apply:

* Clients (a.k.a. service providers) MUST NOT be pre-registered. A look-up in the iSHARE adherence registry is sufficient. It is up to the server to create a new entry for Clients that perform requests for the first time.
* The client_id MUST contain the valid iSHARE identifier of the client.
* Servers SHALL NOT issue refresh tokens.

Generic Authentication Flow
---------------------------

Based on the described standards and specifications in this scheme, the generic iSHARE Human2Machine Authentication flow is described in the following sequence diagram.

.. image:: h2m/resources/H2M-portal.png

The sequence diagram shows how the Service Provider interacts with an Identity Provider in order to receive identity information on the human user (who uses a browser to interact with the Service Provider). The specific details of the steps in this authentication flow are described in the generic API documentation of iSHARE:

1. :ref:`/identity_provider/authorize<refAuthorizeEndpoint>`
2. :ref:`/service_provider/openid_connect1.0/return<refReturnEndpoint>`
3. :ref:`/identity_provider/token<refIDPTokenEndpoint>`
4. :ref:`/identity_provider/userinfo<refUserInfoEndpoint>`

A few remarks regarding this flow:

* Human user might interact with Service Provider in a different way than using a web browser.
* After the Service Provider initiates a POST /token request, the Identity Provider can verify their iSHARE Adherence with the iSHARE Satellite. Adherence checks or certificate validation is not displayed in this flow as this flow only describes the generic OpenID Connect 1.0 flow
* This flow only describes Identification & Authentication of a human user, while in iSHARE it is always relevant that their Authorization (acting on behalf of an organization) is also verified. This process is described in the :ref:`Human Authorization section<refH2MAuthorization>`.