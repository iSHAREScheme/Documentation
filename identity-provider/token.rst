.. _refIDPTokenEndpoint:

Access Token
============

OpenID Connect endpoint for obtaining the OAuth access token and OpenID Connect id token. Response containts, besides the OAuth access token, also an iSHARE compliant JWT ``id_token``.

Request
-------

HTTP methods
~~~~~~~~~~~~

* POST

Headers
~~~~~~~

``Content-Type``
    | **String**.
    | Defines request body content type. MUST be equal to *application/x-www-form-urlencoded*.

Parameters
~~~~~~~~~~

``grant_type``
    | **String**.
    | OAuth 2.0 grant type. MUST be equal to *authorization_code* because code which was retrieved from :ref:`authorize endpoint<refAuthorizeEndpoint>` will be used.

``client_id``
    | **String**.
    | OpenID Connect 1.0 client ID. This parameter respresents iSHARE identifier of Service Provider, so EORI number must be used.

``client_assertion_type``
    | **String**.
    | OpenID Connect 1.0 client assertion type. Used in iSHARE for all client identification for OAuth/OpenID Connect. MUST be qual to *urn:ietf:params:oauth:client-assertion-type:jwt-bearer*.

``client_assertion``
    | **String (JWT)**.
    | OpenID Connect 1.0 client assertion. Used in iSHARE for all client identification for OAuth/OpenID Connect. MUST contain :ref:`JWT token conform iSHARE specifications<refJWT>`, signed by the client.

``redirect_uri``
    | **String**.
    | Redirect URI which was used in authorize request.

``code``
    | **String**.
    | Oauth 2.0 authorization code. MUST be equal to a value of authorization code which was received from the Identity Provider or Identity Broker in :ref:`response to the /authorize request<refAuthorizeCallback>`.

Example
~~~~~~~

::

    > Content-Type: application/x-www-form-urlencoded

    POST /connect/token

    grant_type=authorization_code&
    client_id=EU.EORI.NL000000001&
    client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&
    client_assertion=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsIng1YyI6WyJNSUlFZ1RDQ0FtbWdBd0lCQWdJSU45VmlDRGkzQndzd0RRWUpLb1pJaHZjTkFRRUxCUUF3U0RFWk1CY0dBMVVFQXd3UWFWTklRVkpGVkdWemRFTkJYMVJNVXpFTk1Bc0dBMVVFQ3d3RVZHVnpkREVQTUEwR0ExVUVDZ3dHYVZOSVFWSkZNUXN3Q1FZRFZRUUdFd0pPVERBZUZ3MHhPVEF5TVRVeE1UUTJNVFZhRncweU1UQXlNVFF4TVRRMk1UVmFNRUl4RlRBVEJnTlZCQU1NREVGQ1F5QlVjblZqYTJsdVp6RWNNQm9HQTFVRUJSTVRSVlV1UlU5U1NTNU9UREF3TURBd01EQXdNVEVMTUFrR0ExVUVCaE1DVGt3d2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUMwTzRoVWhEK1ZvT0tWSVpTTk1OVGZ6YzBPMmtZaitaenBRRUFCWkd0UHR5MGtLUEplcDArbzV4c3RvdTFLK1V4dkhmeEVwSHhIR1RkdHFadWMyOExoVTRDZUNnb2VETURUK0NIUzNOb3NpRVNRTXdoL1paZVRjOS9lS0NvNTY5R0NuKzJYdFRpR1NwQlN3TVNXcU5IZ3BBWllLZEhyVC9rRU1JeVRLb2F1dWlLUThjVXA3b3c3bVp6LzlLK3FWM3M5TDAzMFc4SWF3TEpCSksvMmFwQXQ1amgxajQvbUY3ZjBxOHpoemhyQzh2MDFQTGxaZHVUempqQnJlN216K3lpL3ZsWXovZWFwMGVZVGpoeElhdHlWOUZGd2xtaTRGQzFDTmNNdExoOG5zaUpvZTVjQm0xM0xLYlFGdTNHWUg3Nm9lTFp2V3FiUGJwMTFteGxIYS9LZEFnTUJBQUdqZFRCek1Bd0dBMVVkRXdFQi93UUNNQUF3SHdZRFZSMGpCQmd3Rm9BVUZqem5JT25XbE84ZjVhTHh1UHkrNnQ4c040RXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUhBd0V3SFFZRFZSME9CQllFRkFQSCs4VXJZaVZMWGFLUFJHZmxrQStjdXNRN01BNEdBMVVkRHdFQi93UUVBd0lGb0RBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQWdFQVlsNXRXSDBZdFlTOUp5cXlsWkpXb21BNTVTaEtsbGFCUmN2cm82Q0h4bGxKV0hvMHFDOVpUTWN2Q3l3TXYxNFZKeVFkNmVGWnFjVnRPbHVHclJaQmtsSDlBYW5rb3ZwMkpMYXFjRDc5dDFDeXVYWm5JelRGbC9Ca01zRTZ3bEFKWFkvc2Fybm94ZWllalA0RS9FZi8wZXVJRnZCYUlDQ0YrS2QyV0pZYmJuMFd5MGRINDg0UUpiSHlNdFZmcjQyb0lwVU5WdUxTdTg0eUtZQWVtOUpCdVlUcDNZMEsyaGlFQVcvYk9LRHZ2SGV0VmY1ZnU2NnlmZWtEWDUzajNOS2lGSkNYUzJyS0lab0R1TUZ1eHBTeVZrUzJrYldrMSs1Sm95N3FPU05BTlJGUGxwSGNnekxRWnA4SHJndmhzbWhJdDFWVFZZa3l4Y2Q4cVhBbGh3cVZnT3E1TmdMeGtxdWw5aE5NR2lNN3NxK0g3M1EvRmk4aWY3Z1A4SVZBU3pRR3d1SGcyWjg3aWI2QTJ2b24wZlJKWnEzZkl1YkhveEk2M0FUd2ZjUks4NnkxNzJ4YkZFM1ZVMGR1TjF0STVaMFRDZzBHQUpZdEpwYm52ZXhJdDVsazVGSWs0VGh2UjBMOG1OTHkxRFVhMTFOK0VNeGtxYmZxbFR1ckI4WmczQ1kvUWFTS21YWTVDTVV3V2VFQlhSSGh5ZmtaUTVqUFBVSHJGYW95T1JYOHAxRXJZRGt0QjFLOW80am11RVZwQjMzY3ZnWUJFaUF5VjV6NDQyNkZ1VkNNYkhhRkRWN2lLVzllQmxYb3hlWm80WFg4K2pYeVNMNUdXOFh3TlJUSzVjNHZXMDJRM1ZKeVlWZTV1bWVzdHNLUStMUjhpQXpvVVNyZUsxOCtKa0FqQUpVPSJdfQ.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAxIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMSIsImF1ZCI6IkVVLkVPUkkuTkwwMDAwMDAwMDAiLCJqdGkiOiJkeGhKQW1CSEJSeElza2dvVnZCTUpVN1M2MFZxMUVFSCIsImlhdCI6MTU4ODU5NzU1NiwiZXhwIjoxNTg4NTk3NTg2fQ.pdj9gB7MnYbqo9ECWJyK9qlri75BK5DvQB-0db8EGhPk3JVON2f8Rra63nc8B99-2mwndrFr7dfNDONLlmbcBv9xtNGoTQr_W8hrWrXpcUDTfiMXD4vHmDdUy-rNx4eh6H4BjCjt05oDgjnNQ5-jg68mYVlvQOuDPrU347KTNGcsj6J4DUO-C0ovrJuNsRsntmS86s1gKaHTev35Sky0lIsefOfy1_GPXU61Y7lEPTWEkaPaOVQg7ICz4U_J-hoLF7bpLUJulGEESG4JJ6KyUgK_TFu93RKPmwAlRLScDDwQyjrTpOEMnCkA6zCoeefV8BKQZ_Ogb-bBdRVEqE9hvw&
    redirect_uri=https://example.client.com/openid_connect1.0/return&
    code=Dmn-TbSj7OcKl5ym1j5xZsgkabzVP8dMugC81nzmeW4

(URL encoding removed, and line breaks added for readability)

Response
--------

Headers
~~~~~~~

``Content-Type``
    | **String**.
    | Defines response body content type. MUST be equal to *application/json*.

``Cache-Control``
    | **String**.
    | Holds instructions for caching. MUST be equal to *no-store*.

``Pragma``
    | **String**.
    | It is used for backwards compatibility with HTTP/1.0 caches where the ``Cache-Control`` HTTP/1.1 header is not yet present. MUST be equal to *no-cache*.

HTTP status codes
~~~~~~~~~~~~~~~~~

200 OK
    | When a valid request is sent an OK result should be returned.

400 Bad Request
    | When invalid request is sent a Bad Request result should be returned.

Parameters
~~~~~~~~~~

``id_token``
    | **String (JWT)**
    | ID Token value associated with the authenticated session. To understand its structure please refer to :ref:`section below<refIdToken>`.

``access_token``
    | **String**.
    | The access token which will be used to access endpoints that require authorization.

``token_type``
    | **String**.
    | Since we follow OpenID Connect 1.0 specification which is on top of OAuth 2.0 specification, value should be equal to *Bearer*.

``expires_in``
    | **Integer**.
    | Access token expiration time in seconds. Should be *3600*.

.. _refIdToken:

ID Token Parameter JWT
~~~~~~~~~~~~~~~~~~~~~~

In response to the `/token` endpoint request, an ``id_token`` is provided to the client (as an addition to the regular OAuth access token response). This ``id_token`` is an iSHARE compliant JWT, however the ``sub`` parameter is changed and additional parameters are added.

The ``id_token`` contains the modified ``sub`` parameter and the following additional parameters:

``sub``
    | **String**.
    | OpenID Connect 1.0 locally unique and never reassigned identifier within the Identity Provider for the Human Service Consumer, which is intended to be consumed by the client. Also known as iSHARE human pseudonym. In order to understand more about this value, please refer to :ref:`human pseudonym section<refHumanPseudonym>`.

``auth_time``
    | **String**.
    | OpenID Connect 1.0 time when the Human Service Consumer authentication occurred. Formatted in Unix timestamp format.

``nonce``
    | **String**.
    | OpenID Connect 1.0 value used to associate a client session with an ID Token. Contains value as passed in to the /openid_connect1.0/authorize endpoint. The client application needs to verify if the sent value is equal to the value which comes back from IdP /token endpoint response.

``acr``
    | **String**.
    | OpenID Connect 1.0 authentication context class reference value. MUST either contain *urn:http://eidas.europa.eu/LoA/NotNotified/low*, *urn:http://eidas.europa.eu/LoA/NotNotified/substantial* or *urn:http://eidas.europa.eu/LoA/NotNotified/high*, depending on the quality of the authentication method. To understand requirements for each level of assurance, please look at :ref:`LOA table<refTokenLoa>`.

``azp``
    | **String**. *Optional*.
    | OpenID Connect 1.0 authorized party. MUST be identical to the client_id that requested the ID Token. Also identical to aud.

Example
^^^^^^^

.. code-block:: json

    {
      "iss": "EU.EORI.NL983748194",
      "sub": "419404e1-07ce-4d80-9e8a-eca94vde0003de",
      "aud": "EU.EORI.NL123456789",
      "jti": "378a47c4-2822-4ca5-a49a-7e5a1cc7ea59",
      "iat": 1504683445,
      "exp": 1504683475,
      "auth_time": 1504683435,
      "nonce": "c428224ca5a",
      "acr": "urn:http://eidas.europa.eu/LoA/NotNotified/low",
      "azp": "EU.EORI.NLNL123456789",
    }

.. _refTokenLoa:

Levels of Assurance
^^^^^^^^^^^^^^^^^^^

+---------------+--------------------------------------------------------------------------------------------+
| | Level of    | | Identity assurance                                                                       |
| | Assurance   |                                                                                            |
+===============+============================================================================================+
| | Low         | * Present ID from authoritative source                                                     |
+---------------+--------------------------------------------------------------------------------------------+
| | Substantial | * Present ID from authoritative source                                                     |
|               | * ID verification performed by registration authority                                      |
+---------------+--------------------------------------------------------------------------------------------+
| | High        | * In-person ID proofing at registration authority                                          |
|               | * ID verification using official government sources and documents                          |
+---------------+--------------------------------------------------------------------------------------------+

.. _refHumanPseudonym:

Human Pseudonym
^^^^^^^^^^^^^^^

An essential part of the Human2Machine flow is the pseudonym used to refer to humans without exposing their identity.

Pseudonyms are used to obscure the real identities of the human users for privacy issues. It's possible that a human user may be representing more than one organization, which the service provider may not need to know about. If such user uses a single identity then he could be unwillingly giving away this possibly sensitive information.

Using pseudonyms, the user’s identities are not easily linked to each other. On the other hand, some use cases may require the user’s identities to be linkable to service the user better. In this case the use of pseudonym makes sense as a user could always link them together on his own will.

The following is a list of criteria for generating pseudonyms:

* The generation of a pseudonym MUST be non predictable;
* The exact method of generating the pseudonym is left out to Identity Providers;
* The Identity Provider MUST be able to identify the human user from the pseudonym;
* The pseudonym MUST depend on the human user;
* The pseudonym MUST depend on the Identity Provider;
* The pseudonym MUST depend on the Service Provider.

.. tip:: One of the approaches to solve this issue could be a storage with user's identifier, service provider's identifier and UUID/GUID assigned for the combination which in this case would be called *human pseudonym*. 

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/json
    < Cache-Control: no-store
    < Pragma: no-cache

    {
      "id_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsIng1YyI6WyJNSUlFZ1RDQ0FtbWdBd0lCQWdJSU45VmlDRGkzQndzd0RRWUpLb1pJaHZjTkFRRUxCUUF3U0RFWk1CY0dBMVVFQXd3UWFWTklRVkpGVkdWemRFTkJYMVJNVXpFTk1Bc0dBMVVFQ3d3RVZHVnpkREVQTUEwR0ExVUVDZ3dHYVZOSVFWSkZNUXN3Q1FZRFZRUUdFd0pPVERBZUZ3MHhPVEF5TVRVeE1UUTJNVFZhRncweU1UQXlNVFF4TVRRMk1UVmFNRUl4RlRBVEJnTlZCQU1NREVGQ1F5QlVjblZqYTJsdVp6RWNNQm9HQTFVRUJSTVRSVlV1UlU5U1NTNU9UREF3TURBd01EQXdNVEVMTUFrR0ExVUVCaE1DVGt3d2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUMwTzRoVWhEK1ZvT0tWSVpTTk1OVGZ6YzBPMmtZaitaenBRRUFCWkd0UHR5MGtLUEplcDArbzV4c3RvdTFLK1V4dkhmeEVwSHhIR1RkdHFadWMyOExoVTRDZUNnb2VETURUK0NIUzNOb3NpRVNRTXdoL1paZVRjOS9lS0NvNTY5R0NuKzJYdFRpR1NwQlN3TVNXcU5IZ3BBWllLZEhyVC9rRU1JeVRLb2F1dWlLUThjVXA3b3c3bVp6LzlLK3FWM3M5TDAzMFc4SWF3TEpCSksvMmFwQXQ1amgxajQvbUY3ZjBxOHpoemhyQzh2MDFQTGxaZHVUempqQnJlN216K3lpL3ZsWXovZWFwMGVZVGpoeElhdHlWOUZGd2xtaTRGQzFDTmNNdExoOG5zaUpvZTVjQm0xM0xLYlFGdTNHWUg3Nm9lTFp2V3FiUGJwMTFteGxIYS9LZEFnTUJBQUdqZFRCek1Bd0dBMVVkRXdFQi93UUNNQUF3SHdZRFZSMGpCQmd3Rm9BVUZqem5JT25XbE84ZjVhTHh1UHkrNnQ4c040RXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUhBd0V3SFFZRFZSME9CQllFRkFQSCs4VXJZaVZMWGFLUFJHZmxrQStjdXNRN01BNEdBMVVkRHdFQi93UUVBd0lGb0RBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQWdFQVlsNXRXSDBZdFlTOUp5cXlsWkpXb21BNTVTaEtsbGFCUmN2cm82Q0h4bGxKV0hvMHFDOVpUTWN2Q3l3TXYxNFZKeVFkNmVGWnFjVnRPbHVHclJaQmtsSDlBYW5rb3ZwMkpMYXFjRDc5dDFDeXVYWm5JelRGbC9Ca01zRTZ3bEFKWFkvc2Fybm94ZWllalA0RS9FZi8wZXVJRnZCYUlDQ0YrS2QyV0pZYmJuMFd5MGRINDg0UUpiSHlNdFZmcjQyb0lwVU5WdUxTdTg0eUtZQWVtOUpCdVlUcDNZMEsyaGlFQVcvYk9LRHZ2SGV0VmY1ZnU2NnlmZWtEWDUzajNOS2lGSkNYUzJyS0lab0R1TUZ1eHBTeVZrUzJrYldrMSs1Sm95N3FPU05BTlJGUGxwSGNnekxRWnA4SHJndmhzbWhJdDFWVFZZa3l4Y2Q4cVhBbGh3cVZnT3E1TmdMeGtxdWw5aE5NR2lNN3NxK0g3M1EvRmk4aWY3Z1A4SVZBU3pRR3d1SGcyWjg3aWI2QTJ2b24wZlJKWnEzZkl1YkhveEk2M0FUd2ZjUks4NnkxNzJ4YkZFM1ZVMGR1TjF0STVaMFRDZzBHQUpZdEpwYm52ZXhJdDVsazVGSWs0VGh2UjBMOG1OTHkxRFVhMTFOK0VNeGtxYmZxbFR1ckI4WmczQ1kvUWFTS21YWTVDTVV3V2VFQlhSSGh5ZmtaUTVqUFBVSHJGYW95T1JYOHAxRXJZRGt0QjFLOW80am11RVZwQjMzY3ZnWUJFaUF5VjV6NDQyNkZ1VkNNYkhhRkRWN2lLVzllQmxYb3hlWm80WFg4K2pYeVNMNUdXOFh3TlJUSzVjNHZXMDJRM1ZKeVlWZTV1bWVzdHNLUStMUjhpQXpvVVNyZUsxOCtKa0FqQUpVPSJdfQ.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAxIiwic3ViIjoiNDE5NDA0ZTEtMDdjZS00ZDgwLTllOGEtZWNhOTR2ZGUwMDAzZGUiLCJhdWQiOiJFVS5FT1JJLk5MMDAwMDAwMDAwIiwianRpIjoiNzgyYmIzOWUtMjQ4YS00NzA4LWI2MmUtZWZiMDVmYzM2MDQyIiwiZXhwIjoiMTU4ODkyNjczMiIsImlhdCI6IjE1ODg5MjY3MDIiLCJhdXRoX3RpbWUiOiIxNTg4OTI2NzAyIiwibm9uY2UiOiJjNDI4MjI0Y2E1YSIsImFjciI6InVybjpodHRwOi8vZWlkYXMuZXVyb3BhLmV1L0xvQS9Ob3ROb3RpZmllZC9sb3ciLCJhenAiOiJFVS5FT1JJLk5MMDAwMDAwMDAwIn0.CBtljYl9oQzwDI7jjfphHu-GPolEaNDgU8pfBwoowUcIpe__ouz72T-ShBVIR_qKjLa_Hhv_giWX_5clobQdknCUbFJFkQKUoax8Qs1ZPXW2aGO6S83hc9-qZVhWJo8ztW6Nx-6H9GjlJ1UFL2chBp-PTbXLCT_qhGeVuPY0F_4RCX5FcHcxRNnroa2oBM6Oz6OitH4We08JD5SotzHOR_jv-G8gEo97Ur4EhPcIyRGbS8ujKsTUiqzpp6s90qAoi6kHjpuxWbYDR-8lhKs-put4V9w7C2GY3Zm2AfZ87195soAdhntlREz9sxAR8E2cF0ajRMGJw-NS6rxX8FV2jA",
      "access_token": "aW2ys9NGE8RjHPZ4mytQivkWJO5HGQCYJ7VyMBGGDLIOw",
      "expires_in": 3600,
      "token_type": "Bearer"
    }

(Line breaks added for readability)
