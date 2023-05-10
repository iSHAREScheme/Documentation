.. _refIDPLogin:

Login
=====

The ``/login`` endpoint is required in order to pass :ref:`Conformance Test Tool (CTT)<refCTT>`. The endpoint allows user to authenticate himself using username and password. After successful authentication if user grants permit to requested scopes redirection to Service Provider should happen.

.. note:: CTT is going to use low level of assurance because passing login when 2FA is enabled would be infeasible. Production environment should be way more secure and traditional authentication using credentials could be even disabled if there is a need to use more secure ways of logging in like biometrics, ID card logins etc.

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

``username``
    | **String**.
    | Human user's login name. Could be email, mobile phone number, nickname etc.

``password``
    | **String**.
    | Human user's password.

.. note:: It is not mandatory to have exactly the same parameter names because CTT supports any parameter names for credentials.

Example
~~~~~~~

::

    > Content-Type: application/x-www-form-urlencoded

    POST /login

    username=keeper&
    password=P4$$w0rD!

(URL encoding removed, and line breaks added for readability)

Response
--------

HTTP status codes
~~~~~~~~~~~~~~~~~

On successful login could be one of these status codes:

200 OK
    | Login was successful and single page application will be responsible for redirection to ``returnUrl`` parameter.

302 Found
    | Login was successful and back-end application redirects user to ``returnUrl`` parameter by itself.

.. note:: iSHARE documentation does not cover login failures because it's only within Identity Providers scope.

302 Found Example
~~~~~~~~~~~~~~~~~

::

    < Location: https://identity-provider/connect/authorize/callback?authzId=MDK9NtaDCdas75LKQjggWpM8
