.. _refReturnEndpoint:

Return
======

OpenID Connect 1.0 endpoint for receiving the redirect from the Identity Provider or Identity Broker after :ref:`successful human authentication<refAuthorizeCallback>`. 

.. note:: Not bound to name *return*. May have any name the Service Provider chooses.

Request
-------

HTTP methods
~~~~~~~~~~~~

* GET

Parameters
~~~~~~~~~~

``code``
    | Authorization code which is going to be used to request for an :ref:`access token<refIDPTokenEndpoint>`. The authorization code MUST expire shortly after it is issued to mitigate the risk of leaks. A maximum authorization code lifetime of 10 minutes is RECOMMENDED. The client MUST NOT use the authorization code more than once.

``state``
    | OpenID Connect 1.0 opaque value used to maintain state between the request and the callback. The Service Provider needs to verify if initially sent value towards :ref:`authorize endpoint<refAuthorizeEndpoint>` is equal to this returned value.

Example
~~~~~~~

::

    GET /return?
          code=Dmn-TbSj7OcKl5ym1j5xZsgkabzVP8dMugC81nzmeW4&
          state=ZqVQm4zHaEDyBhzpm1ZRH7fsxy703lq2

(Line breaks added for readability)

Response
--------

On successful user redirect to the Service Provider, the Service Provider needs to verify ``state`` parameter and make use of ``code`` parameter in order to retrieve the access token. There are no specific response requirements for this endpoint.