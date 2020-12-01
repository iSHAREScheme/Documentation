.. _refUserInfoEndpoint: 

UserInfo
========

.. error:: Incomplete. UserInfo endpoint soon is going to be changed, so there's no point of finishing this section.

OpenID Connect 1.0 endpoint for obtaining attributes of a Human Service Consumer conform scope defined in access token.

Request
-------

HTTP methods
~~~~~~~~~~~~

* POST

Headers
~~~~~~~

``Authorization``
    | **String**.
    | Oauth 2.0 authorization based on bearer token. MUST contain "Bearer " + access token value. How to retrieve the access token can be found at :ref:`Access Token Endpoint section<refIDPTokenEndpoint>`.

``Content-Type``
    | **String**.
    | Defines request body content type. MUST be *application/json*. It can also contain characters encoding format like *charset=UTF-8*. 

Parameters
~~~~~~~~~~

Example
~~~~~~~

::

    > Authorization: Bearer IIeDIrdnYo2ngwDQYJKoZIhvcNAQELBQAwSDEZMBcGA1UEAwwQaVNIQ
    < Content-Type: application/json; charset=UTF-8

    POST connect/userinfo

Response
--------

Headers
~~~~~~~

``Content-Type``
    | **String**.
    | Defines response body content type. MUST be equal to *application/jwt*.

HTTP status codes
~~~~~~~~~~~~~~~~~

200 OK
    | When a valid request is sent an OK result should be returned.

400 Bad Request
    | When an access token is valid but request itself is invalid.

401 Unauthorized
    | When ``Authorization`` header is either missing, invalid or token has already expired.

Parameters
~~~~~~~~~~

Since response ``Content-Type`` is *application/jwt* it should be expected to retrieve a signed JWT. JWT should be :ref:`iSHARE compliant<refJWTPayload>` and its payload should contain :ref:`delegation evidence<refDelegationEvidence>`. In addition, JWT payload might also contain the following parameters:

``first_name``
    | **String**. *Optional*.
    | First name of the human who's access token is used.

``last_name``
    | **String**. *Optional*.
    | Last name of the human who's access token is used.

``gender``
    | **String**. *Optional*.
    | Gender of the human who's access token is used. Available values are *male*, *female*, **TBD**.

``company_id``
    | **String**. *Optional*.
    | **TBD**.

``company_name``
    | **String**. *Optional*
    | **TBD**.

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/jwt

    example TBD

Decoded JWT Payload
^^^^^^^^^^^^^^^^^^^

.. code-block:: json

    {
        "example": "TBD"
    }
    
