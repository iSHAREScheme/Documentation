.. _refM2MToken:

Access Token (M2M)
==================

This endpoint is used to obtain an OAuth access token from the party. The format of ``access_token`` is not defined by this specification. They are left to the server and should be opaque to the Service Consumer.

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
    | OAuth 2.0 grant type. MUST be equal to *client_credentials*.

``scope``
    | **String**. *Optional*.
    | OAuth 2.0 scope. Defaults to *iSHARE* if not provided, indicating all rights of the Service Consumer are requested. Other values allow the Service Consumer to get tokens that do not include all rights the Service Consumer has.

``client_id``
    | **String**.
    | OpenID Connect 1.0 client ID. Used in iSHARE for all client identification for OAuth/OpenID Connect. MUST contain a valid iSHARE identifier of the Service Consumer.

``client_assertion_type``
    | **String**.
    | OpenID Connect 1.0 client assertion type. Used in iSHARE for all client identification for OAuth/OpenID Connect. MUST be equal to *urn:ietf:params:oauth:client-assertion-type:jwt-bearer*.

``client_assertion``
    | **String (JWT)**.
    | OpenID Connect 1.0 client assertion. Used in iSHARE for all client identification for OAuth/OpenID Connect. MUST contain :ref:`JWT token conform iSHARE specifications<refJWT>`, signed by the client.

Example
~~~~~~~

::

    > Content-Type: application/x-www-form-urlencoded

    POST connect/token

    grant_type=client_credentials&
    scope=iSHARE&
    client_id=EU.EORI.NL000000001&
    client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&
    client_assertion=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsIng1YyI6WyJNSUlFZ1RDQ0FtbWdBd0lCQWdJSU45VmlDRGkzQndzd0RRWUpLb1pJaHZjTkFRRUxCUUF3U0RFWk1CY0dBMVVFQXd3UWFWTklRVkpGVkdWemRFTkJYMVJNVXpFTk1Bc0dBMVVFQ3d3RVZHVnpkREVQTUEwR0ExVUVDZ3dHYVZOSVFWSkZNUXN3Q1FZRFZRUUdFd0pPVERBZUZ3MHhPVEF5TVRVeE1UUTJNVFZhRncweU1UQXlNVFF4TVRRMk1UVmFNRUl4RlRBVEJnTlZCQU1NREVGQ1F5QlVjblZqYTJsdVp6RWNNQm9HQTFVRUJSTVRSVlV1UlU5U1NTNU9UREF3TURBd01EQXdNVEVMTUFrR0ExVUVCaE1DVGt3d2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUMwTzRoVWhEK1ZvT0tWSVpTTk1OVGZ6YzBPMmtZaitaenBRRUFCWkd0UHR5MGtLUEplcDArbzV4c3RvdTFLK1V4dkhmeEVwSHhIR1RkdHFadWMyOExoVTRDZUNnb2VETURUK0NIUzNOb3NpRVNRTXdoL1paZVRjOS9lS0NvNTY5R0NuKzJYdFRpR1NwQlN3TVNXcU5IZ3BBWllLZEhyVC9rRU1JeVRLb2F1dWlLUThjVXA3b3c3bVp6LzlLK3FWM3M5TDAzMFc4SWF3TEpCSksvMmFwQXQ1amgxajQvbUY3ZjBxOHpoemhyQzh2MDFQTGxaZHVUempqQnJlN216K3lpL3ZsWXovZWFwMGVZVGpoeElhdHlWOUZGd2xtaTRGQzFDTmNNdExoOG5zaUpvZTVjQm0xM0xLYlFGdTNHWUg3Nm9lTFp2V3FiUGJwMTFteGxIYS9LZEFnTUJBQUdqZFRCek1Bd0dBMVVkRXdFQi93UUNNQUF3SHdZRFZSMGpCQmd3Rm9BVUZqem5JT25XbE84ZjVhTHh1UHkrNnQ4c040RXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUhBd0V3SFFZRFZSME9CQllFRkFQSCs4VXJZaVZMWGFLUFJHZmxrQStjdXNRN01BNEdBMVVkRHdFQi93UUVBd0lGb0RBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQWdFQVlsNXRXSDBZdFlTOUp5cXlsWkpXb21BNTVTaEtsbGFCUmN2cm82Q0h4bGxKV0hvMHFDOVpUTWN2Q3l3TXYxNFZKeVFkNmVGWnFjVnRPbHVHclJaQmtsSDlBYW5rb3ZwMkpMYXFjRDc5dDFDeXVYWm5JelRGbC9Ca01zRTZ3bEFKWFkvc2Fybm94ZWllalA0RS9FZi8wZXVJRnZCYUlDQ0YrS2QyV0pZYmJuMFd5MGRINDg0UUpiSHlNdFZmcjQyb0lwVU5WdUxTdTg0eUtZQWVtOUpCdVlUcDNZMEsyaGlFQVcvYk9LRHZ2SGV0VmY1ZnU2NnlmZWtEWDUzajNOS2lGSkNYUzJyS0lab0R1TUZ1eHBTeVZrUzJrYldrMSs1Sm95N3FPU05BTlJGUGxwSGNnekxRWnA4SHJndmhzbWhJdDFWVFZZa3l4Y2Q4cVhBbGh3cVZnT3E1TmdMeGtxdWw5aE5NR2lNN3NxK0g3M1EvRmk4aWY3Z1A4SVZBU3pRR3d1SGcyWjg3aWI2QTJ2b24wZlJKWnEzZkl1YkhveEk2M0FUd2ZjUks4NnkxNzJ4YkZFM1ZVMGR1TjF0STVaMFRDZzBHQUpZdEpwYm52ZXhJdDVsazVGSWs0VGh2UjBMOG1OTHkxRFVhMTFOK0VNeGtxYmZxbFR1ckI4WmczQ1kvUWFTS21YWTVDTVV3V2VFQlhSSGh5ZmtaUTVqUFBVSHJGYW95T1JYOHAxRXJZRGt0QjFLOW80am11RVZwQjMzY3ZnWUJFaUF5VjV6NDQyNkZ1VkNNYkhhRkRWN2lLVzllQmxYb3hlWm80WFg4K2pYeVNMNUdXOFh3TlJUSzVjNHZXMDJRM1ZKeVlWZTV1bWVzdHNLUStMUjhpQXpvVVNyZUsxOCtKa0FqQUpVPSJdfQ.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAxIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMSIsImp0aSI6ImE1MjJjZWZkNGNmNjQyMWE4ZGUzOGJjYjBjMDhlYjliIiwiaWF0IjoxNTU2MDM0NzM0LCJuYmYiOjE1NTYwMzQ3MzQsImV4cCI6MTU1NjAzNDc2NCwiYXVkIjoiRVUuRU9SSS5OTDAwMDAwMDAwMCJ9.SU59EXhAukbDVP0Y8Yb_1-5Za7QCgAtgq_bh9qRKNY0t3P7nodr2b6ue2DqmIZ_bvysC77zX01QCiCCT3vT7iU4ee4HINMP9gsujoNC0L1ONL2twoJeE91hWUke8dBL9m_ipP0x5-XivQAdS9vJTHQu1A_m5VB0O_XD4JGLwrwjD2d-UE4Fhyy4ilKSPKFpqhoAi2qPkmonZki-RaYoPkrq49LW_v8OVKW7yFJvEDIwph0hEcWxl0udyeu3Cy35NWMnLZdu6gp2f4yxOq3FPrufO5bT0aihioI04V8avggzVJdVcrDTK9Q0Hzhs-22VamkncUZqPvRmo_uwypNHFBg

(URL encoding removed, and line breaks added for readability)

Response
--------

Headers
~~~~~~~

``Content-Type``
    | **String**.
    | Defines response body content type. MUST be equal to *application/json*.

HTTP status codes
~~~~~~~~~~~~~~~~~

200 OK
    | When a valid request is sent an OK result should be returned.

400 Bad Request
    | When invalid request is sent a Bad Request result should be returned.

Parameters
~~~~~~~~~~

``access_token``
    | **String**.
    | The access token which will be used to access endpoints that require authorization.

``token_type``
    | **String**.
    | Since we follow OAuth 2.0 specification value should be equal to *Bearer*.

``expires_in``
    | **Integer**.
    | Access token expiration time in seconds. Should be *3600*.

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/json

    {
      "access_token": "aW2ys9NGE8RjHPZ4mytQivkWJO5HGQCYJ7VyMBGGDLIOw",
      "token_type": "Bearer",
      "expires_in": 3600
    }

(Line breaks added for readability)