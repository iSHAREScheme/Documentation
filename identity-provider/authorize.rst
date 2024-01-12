.. _refAuthorizeEndpoint:

Authorize
=========

OpenID Connect endpoint for redirecting Human Service Consumer for authentication by the Identity Provider. Server response is directed to the :ref:`/service_provider/openid_connect1.0/return endpoint<refReturnEndpoint>`.

Request
-------

HTTP methods
~~~~~~~~~~~~

* POST

.. note:: Since :ref:`request object<refAuthorizeRequestObject>` is too large for GET requests only POST method should be supported.

Headers
~~~~~~~

``Content-Type``
    | **String**.
    | Defines request body content type. MUST be equal to *application/x-www-form-urlencoded*.

Parameters
~~~~~~~~~~

``response_type``
    | **String**.
    | OAuth 2.0 Response Type. For the Authorization Code Flow used within iSHARE, value *code* is REQUIRED. MUST be identical to the ``response_type`` value in the ``request`` parameter.

``client_id``
    | **String**.
    | OpenID Connect 1.0 client ID. This parameter respresents iSHARE identifier of Service Provider, so EORI number must be used. MUST be identical to the client_id value in the ``request`` parameter.

``scope``
    | **String**.
    | OAuth 2.0 scope for OpenID Connect 1.0. MUST contain the *openid* and *iSHARE* scope values and MAY contain one or more scopes identifying the attributes from the Human Service Consumer that are requested. Scope values determine the permissions to be asked to the user. MUST be identical to the scope value in the ``request`` parameter.

.. note:: According to `RFC 6749 <https://tools.ietf.org/html/rfc6749>`_, scopes are case-sensitive. 

.. _refAuthorizeRequestObject:

``request``
    | **String (JWT)**.
    | OpenID Connect 1.0 signed JWT containing all request parameters. Look into :ref:`section below<refAuthorizeJwtContents>` to understand request parameter contents. See also :ref:`Generic iSHARE JWT specifications<refJWT>` for a.o. basic content and signing requirements.

.. _refAuthorizeJwtContents:

Request Parameter JWT
~~~~~~~~~~~~~~~~~~~~~

This parameter is an :ref:`iSHARE compliant JWT<refJWTPayload>`, with additional parameters within this token. The ``request`` JWT contains the modified ``sub`` parameter and the following additional parameters:

``sub``
    | **String**.
    | This parameter overrides iSHARE compliant JWT payload. A URN specifying subject for this authorization request. Since ID or pseudonym of the user is not known upfront, *urn:TBD* value should be used (TBD means To Be Determined). In response, a pseudonym of the user MUST be returned by the Identity Provider.

``response_type``
    | **String**.
    | OAuth 2.0 Response Type. In order to use the Authorization Code Flow in iSHARE, value *code* is REQUIRED. MUST be identical to the response_type value in the body parameter of the /authorize request.

``client_id``
    | **String**.
    | OpenID Connect 1.0 client ID. Used in iSHARE for all client identification for OAuth/OpenID Connect. MUST contain a valid iSHARE identifier. MUST be identical to the client_id value in the body parameter of the /authorize request.

``scope``
    | **String**.
    | OAuth 2.0 scope for OpenID Connect 1.0. The `scope` parameter MUST contain at last the *openid* and the *iSHARE* scope values. In addition to that it and MAY also contain one or more scopes identifying the attributes from the Human Service Consumer that are requested (depending on the OpenID implementation of the Identity Provider). The *iSHARE* scope contains the minimal information required for authorisations. The `scope` parameter MUST be identical to the scope value in the body parameter of the /authorize request. MUST be identical to the scope value in the body parameter of the /authorize request.

.. _refRedirectUriParameter:

``redirect_uri``
    | **String**.
    | OpenID Connect 1.0 redirection URI to which the response will be sent. Note that by transporting the redirect_uri in a signed and encrypted JWT, security considerations regarding un-pre-registered redirect_uri's are properly addressed.

``state``
    | **String**.
    | OpenID Connect 1.0 opaque value used to maintain state between the request and the callback. The client application needs to verify if the sent value is equal to the value which comes back from IdP /authorize endpoint response.

``nonce``
    | **String**.
    | OpenID Connect 1.0 value used to associate a client session with an ID Token. The client application needs to verify if the sent value is equal to the value which comes back from IdP /token endpoint response.

``acr_values``
    | **String**.
    | OpenID Connect 1.0 authentication context class reference value. Space-separated string that specifies the acr values that the Identity Provider is being requested to use for processing this request, with the values appearing in order of preference. MUST either contain *urn:http://eidas.europa.eu/LoA/NotNotified/low*, *urn:http://eidas.europa.eu/LoA/NotNotified/substantial* or *urn:http://eidas.europa.eu/LoA/NotNotified/high*, depending on the quality of the authentication method. To understand authentication requirements for each level of assurance, please look at :ref:`LOA table<refAuthorizeLoa>`.

``language``
    | **String**. *Optional*.
    | iSHARE specific two-letter indicator (ISO 639-1 Code) that guides the language of the user interface shown by the Identity Broker or Identity Provider. If provided must display login page according to provided language, else should display default page.

Example
^^^^^^^

.. code-block:: json

    {
      "iss": "EU.EORI.NL123456789",
      "sub": "urn:TBD",
      "aud": "EU.EORI.NL987654321",
      "jti": "378a47c4-2822-4ca5-a49a-7e5a1cc7ea59",
      "iat": 1504683445,
      "exp": 1504683475,
      "response_type": "code",
      "client_id": "EU.EORI.NL123456789",
      "scope": "openid ishare name contact_details",
      "redirect_uri": "https://example.client.com/openid_connect1.0/return",
      "state": "af0ifjsldkj",
      "nonce": "c428224ca5a",
      "acr_values": "urn:http://eidas.europa.eu/LoA/NotNotified/high",
      "language": "nl"
    }

.. _refAuthorizeLoa:

Levels of Assurance
^^^^^^^^^^^^^^^^^^^

+---------------+--------------------------------------------------------------------------------------------+
| | Level of    | | Authentication assurance                                                                 |
| | Assurance   |                                                                                            |
+===============+============================================================================================+
| | Low         | * Single factor, e.g. username and password                                                |
+---------------+--------------------------------------------------------------------------------------------+
| | Substantial | * Multi-factor, e.g. mobile phone + PIN                                                    |
+---------------+--------------------------------------------------------------------------------------------+
| | High        | * Multi-factor, e.g. mobile phone + PIN                                                    |
|               | * Must access private data/keys stored on tamper-resistant hardware token                  |
|               | * Cryptographic protection of personally identifying information (PII)                     |
+---------------+--------------------------------------------------------------------------------------------+

Example
~~~~~~~

.. tip:: ``request`` parameter is encrypted, so you won't be able to inspect its payload. However, if you'd like to see JWT payload please refer to :ref:`section above<refAuthorizeJwtContents>`.

::

    > Content-Type: application/x-www-form-urlencoded

    POST /connect/authorize

    response_type=code&
    client_id=EU.EORI.NL000000001&
    scope=iSHARE openid&
    request=eyJ0eXAiOiJKV1QiLCJ4NWMiOlsiTUlJRWdUQ0NBbW1nQXdJQkFnSUlOOVZpQ0RpM0J3c3dEUVlKS29aSWh2Y05BUUVMQlFBd1NERVpNQmNHQTFVRUF3d1FhVk5JUVZKRlZHVnpkRU5CWDFSTVV6RU5NQXNHQTFVRUN3d0VWR1Z6ZERFUE1BMEdBMVVFQ2d3R2FWTklRVkpGTVFzd0NRWURWUVFHRXdKT1REQWVGdzB4T1RBeU1UVXhNVFEyTVRWYUZ3MHlNVEF5TVRReE1UUTJNVFZhTUVJeEZUQVRCZ05WQkFNTURFRkNReUJVY25WamEybHVaekVjTUJvR0ExVUVCUk1UUlZVdVJVOVNTUzVPVERBd01EQXdNREF3TVRFTE1Ba0dBMVVFQmhNQ1Rrd3dnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDME80aFVoRCtWb09LVklaU05NTlRmemMwTzJrWWorWnpwUUVBQlpHdFB0eTBrS1BKZXAwK281eHN0b3UxSytVeHZIZnhFcEh4SEdUZHRxWnVjMjhMaFU0Q2VDZ29lRE1EVCtDSFMzTm9zaUVTUU13aC9aWmVUYzkvZUtDbzU2OUdDbisyWHRUaUdTcEJTd01TV3FOSGdwQVpZS2RIclQva0VNSXlUS29hdXVpS1E4Y1VwN293N21aei85SytxVjNzOUwwMzBXOElhd0xKQkpLLzJhcEF0NWpoMWo0L21GN2YwcTh6aHpockM4djAxUExsWmR1VHpqakJyZTdteit5aS92bFl6L2VhcDBlWVRqaHhJYXR5VjlGRndsbWk0RkMxQ05jTXRMaDhuc2lKb2U1Y0JtMTNMS2JRRnUzR1lINzZvZUxadldxYlBicDExbXhsSGEvS2RBZ01CQUFHamRUQnpNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVGanpuSU9uV2xPOGY1YUx4dVB5KzZ0OHNONEV3RXdZRFZSMGxCQXd3Q2dZSUt3WUJCUVVIQXdFd0hRWURWUjBPQkJZRUZBUEgrOFVyWWlWTFhhS1BSR2Zsa0ErY3VzUTdNQTRHQTFVZER3RUIvd1FFQXdJRm9EQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FnRUFZbDV0V0gwWXRZUzlKeXF5bFpKV29tQTU1U2hLbGxhQlJjdnJvNkNIeGxsSldIbzBxQzlaVE1jdkN5d012MTRWSnlRZDZlRlpxY1Z0T2x1R3JSWkJrbEg5QWFua292cDJKTGFxY0Q3OXQxQ3l1WFpuSXpURmwvQmtNc0U2d2xBSlhZL3Nhcm5veGVpZWpQNEUvRWYvMGV1SUZ2QmFJQ0NGK0tkMldKWWJibjBXeTBkSDQ4NFFKYkh5TXRWZnI0Mm9JcFVOVnVMU3U4NHlLWUFlbTlKQnVZVHAzWTBLMmhpRUFXL2JPS0R2dkhldFZmNWZ1NjZ5ZmVrRFg1M2ozTktpRkpDWFMycktJWm9EdU1GdXhwU3lWa1Mya2JXazErNUpveTdxT1NOQU5SRlBscEhjZ3pMUVpwOEhyZ3Zoc21oSXQxVlRWWWt5eGNkOHFYQWxod3FWZ09xNU5nTHhrcXVsOWhOTUdpTTdzcStINzNRL0ZpOGlmN2dQOElWQVN6UUd3dUhnMlo4N2liNkEydm9uMGZSSlpxM2ZJdWJIb3hJNjNBVHdmY1JLODZ5MTcyeGJGRTNWVTBkdU4xdEk1WjBUQ2cwR0FKWXRKcGJudmV4SXQ1bGs1RklrNFRodlIwTDhtTkx5MURVYTExTitFTXhrcWJmcWxUdXJCOFpnM0NZL1FhU0ttWFk1Q01Vd1dlRUJYUkhoeWZrWlE1alBQVUhyRmFveU9SWDhwMUVyWURrdEIxSzlvNGptdUVWcEIzM2N2Z1lCRWlBeVY1ejQ0MjZGdVZDTWJIYUZEVjdpS1c5ZUJsWG94ZVpvNFhYOCtqWHlTTDVHVzhYd05SVEs1YzR2VzAyUTNWSnlZVmU1dW1lc3RzS1ErTFI4aUF6b1VTcmVLMTgrSmtBakFKVT0iXX0.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAxIiwic3ViIjoidXJuOlRCRCIsImF1ZCI6IkVVLkVPUkkuTkwwMDAwMDAwMDAiLCJqdGkiOiJicXEwem5rY2RvQ3BjRWdRbXNuUEQyYnh3MWJoa0ZVViIsImlhdCI6MTYwMTM3Mjg2MCwiZXhwIjoxNjAxMzcyODkwLCJyZXNwb25zZV90eXBlIjoiY29kZSIsImNsaWVudF9pZCI6IkVVLkVPUkkuTkwwMDAwMDAwMDEiLCJzY29wZSI6ImlTSEFSRSBvcGVuaWQiLCJyZWRpcmVjdF91cmkiOiJodHRwczovL2V4YW1wbGUuY2xpZW50LmNvbS9vcGVuaWRfY29ubmVjdDEuMC9yZXR1cm4iLCJzdGF0ZSI6IjBGcnF5Mzlja3NmNHZaSFk0RHluRHpYQmtBVmdNbFJ5Iiwibm9uY2UiOiJlYlFqVTc1Vkl4cVczM3RITkZmRmlLbVJHUDZFMlZjNCIsImFjcl92YWx1ZXMiOiJ1cm46aHR0cDovL2VpZGFzLmV1cm9wYS5ldS9Mb0EvTm90Tm90aWZpZWQvbG93IiwibGFuZ3VhZ2UiOiJubCJ9.ZXlKcGMzTWlPaUpGVlM1RlQxSkpMazVNTURBd01EQXdNREF4SWl3aWMzVmlJam9pZFhKdU9sUkNSQ0lzSW1GMVpDSTZJa1ZWTGtWUFVra3VUa3d3TURBd01EQXdNREFpTENKcWRHa2lPaUppY1hFd2VtNXJZMlJ2UTNCalJXZFJiWE51VUVReVluaDNNV0pvYTBaVlZpSXNJbWxoZENJNk1UWXdNVE0zTWpnMk1Dd2laWGh3SWpveE5qQXhNemN5T0Rrd0xDSnlaWE53YjI1elpWOTBlWEJsSWpvaVkyOWtaU0lzSW1Oc2FXVnVkRjlwWkNJNklrVlZMa1ZQVWtrdVRrd3dNREF3TURBd01ERWlMQ0p6WTI5d1pTSTZJbWxUU0VGU1JTQnZjR1Z1YVdRaUxDSnlaV1JwY21WamRGOTFjbWtpT2lKb2RIUndjem92TDJWNFlXMXdiR1V1WTJ4cFpXNTBMbU52YlM5dmNHVnVhV1JmWTI5dWJtVmpkREV1TUM5eVpYUjFjbTRpTENKemRHRjBaU0k2SWpCR2NuRjVNemxqYTNObU5IWmFTRmswUkhsdVJIcFlRbXRCVm1kTmJGSjVJaXdpYm05dVkyVWlPaUpsWWxGcVZUYzFWa2w0Y1Zjek0zUklUa1ptUm1sTGJWSkhVRFpGTWxaak5DSXNJbUZqY2w5MllXeDFaWE1pT2lKMWNtNDZhSFIwY0RvdkwyVnBaR0Z6TG1WMWNtOXdZUzVsZFM5TWIwRXZUbTkwVG05MGFXWnBaV1F2Ykc5M0lpd2liR0Z1WjNWaFoyVWlPaUp1YkNKOQ

(URL encoding removed, and line breaks added for readability)

Response
--------

HTTP status codes
~~~~~~~~~~~~~~~~~

302 Found
    * When a valid request is sent a redirection should happen to :ref:`Identity Provider's login page<refIDPLogin>` to allow user to authenticate himself.
    * When invalid request is sent a redirection should happen to Identity Provider's error page. Redirection should not be made to URI which was provided in a request JWT payload :ref:`redirect_uri parameter<refRedirectUriParameter>` due to potential security risks. To learn more please read `OAuth 2.0 Security: OAuth Open Redirector section 2 <https://tools.ietf.org/html/draft-bradley-oauth-open-redirector-00#section-2>`_.

.. _refAuthorizeResponseParameters:

Parameters
~~~~~~~~~~

``returnUrl``
    | On successful request a redirection to login should happen. Once user has logged in, :ref:`callback to authorize<refAuthorizeCallback>` endpoint needs to be done in order to issue a *code* to Service Provider. This parameter value should be an ecoded URL to the callback endpoint.

.. warning:: Authorize callback endpoint usually requires the same parameters that were sent towards authorize endpoint in order to identify which request was that. Signed and encrypted JWT is too long and *MUST NOT* be included into ``returnUrl``.

302 Found Example
~~~~~~~~~~~~~~~~~

::

    < Location: https://identity-provider/login?
        returnUrl=https://identity-provider/connect/authorize/callback?authzId=MDK9NtaDCdas75LKQjggWpM8

(URL encoding removed, and line break added for readability)

.. _refAuthorizeCallback:

Callback
--------

On successful login callback towards authorize endpoint is invoked. It's out of iSHARE's scope to document Identity Provider's internal functionality. However there still are a few requirements because :ref:`Service Provider's return endpoint<refReturnEndpoint>` expects a specific call.

On successful callback Identity Provider should redirect user to URI which was provided in a request JWT payload :ref:`redirect_uri parameter<refRedirectUriParameter>` with added query parameters that are defined in a section below.

Parameters
~~~~~~~~~~

``code``
    | Authorization code which is going to be used to request for an :ref:`access token<refIDPTokenEndpoint>`. The authorization code MUST expire shortly after it is issued to mitigate the risk of leaks. A maximum authorization code lifetime of 10 minutes is RECOMMENDED. The client MUST NOT use the authorization code more than once. If an authorization code is used more than once, the authorization server MUST deny the request and SHOULD revoke (when possible) all tokens previously issued based on that authorization code. The authorization code is bound to the client identifier and redirection URI.

``state``
    | OpenID Connect 1.0 opaque value used to maintain state between the request and the callback. The client application needs to verify if the sent value is equal to this returned value.

302 Found Example
~~~~~~~~~~~~~~~~~

::

    < Location: https://example.client.com/openid_connect1.0/return?
        code=Dmn-TbSj7OcKl5ym1j5xZsgkabzVP8dMugC81nzmeW4&
        state=ZqVQm4zHaEDyBhzpm1ZRH7fsxy703lq2

(Line breaks added for readability)