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
    | OAuth 2.0 scope for OpenID Connect 1.0. MUST contain the *openid* and *iSHARE* scope values and MAY contain one or more scopes identifying the attributes from the Human Service Consumer that are requested. Scope values determine the permissions to be asked to the user. MUST be identical to the scope value in the ``request`` parameter. According to `RFC 6749 <https://tools.ietf.org/html/rfc6749>`_, scopes are case-sensitive. 

.. _refAuthorizeRequestObject:

``request``
    | **String (JWE)**.
    | OpenID Connect 1.0 signed and encrypted JWT (a.k.a. :ref:`JWE<refJWE>`) containing all request parameters. Look into :ref:`section below<refAuthorizeJwtContents>` to understand request parameter contents. See also :ref:`Generic iSHARE JWT specifications<refJWT>` for a.o. basic content and signing requirements.

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

    POST connect/authorize

    response_type=code&
    client_id=EU.EORI.NL000000001&
    scope=iSHARE openid&
    request=eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZHQ00iLCJ0eXAiOiJKV0UifQ.GEPJElTNyTUyBM4N1F-1kky2-OxeUnZxwwx_Ofs75a_C-CFriFWhavUWfHOuL4sc_8KkcQlj3DIMCDI8lmmVfFOpbRTnf4TyMqJ3llKEotiF1eRf0E0kGGvYGT_2304VLX1jg0v19KGD9mqYEi6ngvpiFlTC6e-BKpwQ5VqlUOWwAiWXDIVMcDudhXyCowny9ccFRkqxYdCJ3sd78JlUhdmZ_xUHIObJRgAIjC2uJ86agdfDZf02cG_izyHSF3Gprn5inkjjVil1GvC1HS7HGZFaTzrP3uxxT5lrAXiRIalgosTy2dbQ59hB4bRJOCOf9DWl1KvgZbLGtBN8zZVF3A.PQMwL7UIbUU7O4An.7Xul6t7u-cyX8AgxEhXfi-C92HjTjvfWgRB7vWrinT7ncqerkP8LnVGo_PyvSydcsMurz8VnTxehLXqjbMNCpCPd1XVpxjtCzpgJ1S6wyhLgirsOcc3fqo2JHnQI04GFdk28Pz-aVDF2bqKsROUyI68gyaR5Jiqz-ebDfSM1QsssKZacuC16gCcBQKED4_XT0IEOU1Qf9OkBXV3wjkl8DaD7r2VkXGsZ8l9S7ZcDenS0Pwwm8rVaZXPIHprU76jy4TChCYo3CsfehD0Micdz8GDuSmN7vLoOBLlUPCs7yleqCO2HqV0c2NQiDAnDS9hi3-0UGQCSkT5VkxqBZ2VMXDojwKVnIQtGm0UJHz7fBq8my-SF3BYdp5Ss5-y1NZH3ZzTUbu8Kw21PZLxigN9MlPatUUOvPqn-ZBmT9YhnagO1rY9lNjcpHZ84AZk3WNj7yfRiZuyCBxX539nb7w7w2GiAdJgTmARSRRnO587MBkhJ2W8_9gyYEcgYET_qWQtzJLYHdmDeq5xuupi3Lq3bBkhVwb48hXUArC8qFpFtSUNSC-aXYktkc4_KPWQfS7gclej2JAkygxmHj3UEGbb-oB2gWik2vKCTdjH1NRjKLkHmLUkoF2tTzqMGWmKo3rkk_-FYrHndr1DbyYcM59GNoXq-RcN6lvMWW5flOBmtjDl5w92zSXwXozKBGNiU20UdvUvYyP46x9K2QgxzPHQK6BDvvvfrmixYQFAphT3AycEd-zDA5duYlRJevDmDdyHCKRQ677ZReG8LiiaTgkzzZYrOtB9iPeNXZfFzpcrGY5qmwVKxdA8_Ev6pII-hBC66TJqCgDctgjKd3igUraiRmeEW9jUYW6oplnX1JUKjNRhtuk5o0U_YuVS3PlURna5SGRDu4pxMY2NVHIgcQLKDNtbMO_CN_So6Yk2fyJswLLsGuhhVuBaOZ77pDHv2gYDEsSTH_nrF0qaZHoilR-trEDyxA8Jusu30nDnL7gkBKcgvTUvCmabPCddM1hH_9rnS85fO-PxjCn_gHAzixLJuYLSXuCfxX37gAXyt3ERbKED_WWYHu6yWq0k8jbHc7MMyF_zj4i3jwN8GRYIbq2jk_GtyMIimtZz2PsoIWMDLUP1qExr2VdXceEFkaTyx2MNz9pR9me63uR2Ryt_mJ7PepMPbvT4KVQfSRbZLfhWKLN3cu1xGyZVb5dc4dJaHCA3sZ_HhELrDtXRltWF2g69V19Hzo6PSNpMH0KeQKrVKtzX1oW6d62jMPFEu7ckGrdIOYuNpo8pbbVqahcNcXmZKmYpDRfCt435ojF11Rl98Z7_d1d0b2fxRh4-o5esY2uL6S-Yxm3oJu2WLESfRwCa8JdsUyYHNG9RwESOiKDUfeIM5RTA9BTVq96V0F7qtzjmZQjWAV1grnQXsIzzZpvs3gXLX_dDs8AiZ9CY8j6pSGait5xkHZ5tp7e_fIxyXZAe0z3RRloOXWuMIbqq3NAytyhqvVpHHHELeoc9yifSQOw_0rlrhEV_iHW49DdPEuzR4l4rJPNmPWfCCku0RcnrEl7EBXgwb_xnMTWiDkAV4th7uYf61JIqotQ7CuvIcrs5rRH5SkSoso45mxaZFbYygfOO4uapx5dKwAbTiwsNTUCuyBOwEPLoLATnBDTiasiU3cUIpY5fCMxwewylVEAD65iwuKX9RSdOAjtzsazEnhYNNkZVToxEVNv2VUgZ3c-4uikWnLWU0eyHS3Czw27DEx_4B5GOJJQZAr3jERK-wWLoT-eAPHJk21Km5ubDh2wb87l_cWM_1z4iFgyDGjB-VqXAp_JJ2lcr5UbNnQYKj6qiTjIBsD9rmXmr6z21OEHgrnbZD13HRmne2wg3hqSsD4Su54pXExROvN3w3n9Zs9zGbPUsxwfhj1B4uWLmBjqgHdMAhLBBj4jTV4E5yD6O8w1VeiyV5HAPseFIQjRkEwX4jvnpzu2FRzw_1JpZ3k--EcoHeI3mi6OT6b_U5MZeNcPKc1K3U0XZggLk4N4M_Wcvd_Ch7nZlSwL3mdW1azmYzm6sBd7Tbh-PGR9D9mSHTNyQTjOuPRb17Tr08RFkijdCy3ZRPhoew-G7ImE61pwFIq7ArmxkFjDBI3mnxCpw3n-4XJ8LCZFR8a5nnAsBtY8k3XaxO7GUunmImB__yp-kMytGIJ39UDsZ0t3YjZvA0z1zJLHePqvwItZ2EmlXtbVDxZvQemusaWAkiUmY-cAc_48GRbcVYnsIqlkkm5c8mJ3tTBrfxnmaa8pxruIKzg3DTqsG-Baeamx2sq0ReTnBUkUzk0LvEuglKxeVpTOIIxzruxhoWdyfl2N6Z0Z3Y2RYLbTVBLM5Yz9wp1tGeg5JttgUuUP5LsBfSH5AAtOMfX4oDjwrHULrNDr5_Tk1OFGQvQ4H83C8WS1lyf1PNq5D_8mgKSlh63R1XRQ5zvWKZF4kk_aBe0twP9vcLTE8NtWIlyvewEasSO1cqd8CPt6z-k-We8HXHvS1CIK0TlMXN0yJKFmAXFTZGGY_qgXmqqkDaHsFzBQoOJq8wtUpQe3sOjA6WkF3s7XY7SQB0oAgY-vAUkZ2SnxfUZ30NS1hUhwTiNLYmPADE8Tz825fucn26dKWPgiElWAxzij7bOinRQzLnJs9tMJqn57juehSj1DbzfhhsgfvBhDwiFIuuujfAQUhJxYzWitUBRx9dh8j_CYcc3jLt10v5J8J35xQ6Gykz_HuyVAgJxLvF_oBKg2pk0cQQKgepLzyg1dLSKh6P_di_H5_pvN8LRymFSiCUNiX81KYTqGxaYcTeW748tNJDaqMZZJ1xtnF-qQO6zVPTBaIHHlT6isgQGpHZbH2Td06N9IpedIkq2uCEFZRnyXZxwsU2fbzwgyGaQdXI0Ebs6SIVac3kGNfMmUxKmflWXMb20p1sb-daqU7XjiD6O_bW8lC1hNxyiOQtd8ioSDE-3uw-tAI17vfO9BXunluLmREU8KuHiuwOD6iAKrIWowD-afP3NoZUmInaQ3C5Yw0eLMg3uYFwxcBcYDGaFtJoKIUB71NXVPLWtDuqB1Fh9HRTIusSZ1zO6uzbyJwThUqOEtfm8yzHOfu7_RAS7tmwtSx0npk2JMO-CtiouyCikmWzx20NCzl1UmGBX9p5AQ5JXjWutHXmbgASxLkPfydNNkv6R43CL2-D-X-0O4oD6_0r2_Bw-V2cehQw6zmKOucwTLO6fDN2GuXLzJwznttZQIOoQ4FeL7-jgKvFVhxbESWOn2Y4891DMJu16YilsGESeyMsYHZLNRCEk_xMVjgEbYODNisxF1maER1doatg2_tSjqAkzZfasq208FKYeFMpfCA0nA4-5TLOeG13ThtqLlyTpZD0Bt1ZuuY8XIumZCu5c7Ae8eZCCpyrl7aUzPxxqYOBj3moQ5rcd1oQvdKy287V-92kAO3g9tM3k1qU8mD9wmQuIYawoaUSbj9AbXD6rafJt0qBp_gzZ1wCavoNLvuJC5cncLaWnlvQMPz1yqdxvpsjouKNqQpgr1u-U-wjCecLYX_brmO8yjr99qpDlQnHMmBIs_PftsQQJWYrDWQJ0r8TYQEk2vuVQOtSIvoAcexnpjBF3QJep2FaeZntFBNW9jnpfEijcP5ZbGC2NOUIKAuSf_rtkusAs-5oKeZRd2UkxK0XjZ1dMN-92ZlNRKcLfYH37of4BFlvZ-EG3UruYV9ugOLrjy9USc36Zzq6jpa0JgaxEXryYbhgzJmqsPxtKmrbqs1ybRtC4LDSCFc4FgVwmXtnraqT_VjCFs52pMcPu7pqezd0gDU8mg5xz_6654b4R8OkwtLbXKepaquUwx1qGgl5OhWV4A9U_5_enEL6DgHy4PP1DxDgRWFeEMs_O1KDNTdgOr2IQKKy9_OVAb6kWqjiPhPll90C0j6wM644yblo3XCM2OvP1PBLTd_iFeRv9lCr-0l4H0rKoVIYH5QII58hzVEVknYBfMkpKedT8GVSeRj9j9gGsiAOUmCylYtCTYUnhGKFUX8q0OUWj_AfhWEqRRkbBkPli47NsxnJ6xNKp0tLyL3qVnOgJgZ1yEPbj3a1DiZJsH3XYA.UgefTxabL0Oj1RDVPrUo1A

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