.. _refServiceEndpoint:

Service
=======

This is an abstract service (business specific) endpoint to show how any Service Provider that adheres to iSHARE MUST apply iSHARE conformant OAuth to every iSHARE enabled service.

Request
-------

Request can make use of any HTTP method and can contain any extra headers. Parameters are undefined because they vary for each Service Provider due to their business specific logic.

Headers
~~~~~~~

``Authorization``
    | **String**.
    | OAuth 2.0 authorization based on bearer token. MUST contain "Bearer " + access token value. How to retrieve the access token can be found at :ref:`Access Token Endpoint section<refM2MToken>`.

``delegation_evidence``
    | **String**. *Optional*.
    | iSHARE delegation evidence regarding the requested service. The Service Consumer can obtain this evidence from a :ref:`Delegation Endpoint<refDelegationEndpoint>` before requesting a specific service.

``service_consumer_assertion``
    | **String**. *Optional*.
    | iSHARE specific optional client assertion. Used when a Service Consumer is requesting a service on behalf of another Service Consumer in a *service broker* pattern. It is used to prove that the *brokering* Service Consumer indeed has had a request from the original Service Consumer.

``LicensePurpose``
    | **String**. *Optional*.
    | iSHARE specific value describing the purpose of the license the Service Consuming Entity requests for the data in the service response

Response
--------

Response can make use of any HTTP status code and can contain any extra headers. Parameters are undefined because they vary for each Service Provider due to their business specific logic.

Headers
~~~~~~~

``LicensePurpose``
    | **String**. *Optional*.
    | iSHARE specific value describing the purpose of the license the Service Consuming Entity receives for the data in the service response.

``LicenseSubLicense``
    | **String**. *Optional*.
    | Optional iSHARE specific value describing the amount of sub license(s) the Service Consuming Entity is allowed to issue for the data in the service response.

``LicenseEndDate``
    | **String**. *Optional*.
    | Optional iSHARE specific value describing the duration of the license for the data in the service response.
