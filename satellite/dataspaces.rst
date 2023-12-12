.. _refDataspaces:

Dataspaces
============

Request dataspaces from Satellite


Parameters
~~~~~~~~~~

``Authorization``
    | **String (JWT)**.
    | OAuth 2.0 authorization based on bearer token. MUST contain “Bearer ” + access token value. How to retrieve the access token can be found at Access Token Endpoint section.


Response
--------

200
    

Extensions
~~~~~~~

``x-operation-settings``
    | **String**.
    | {"CollectParameters":false,"AllowDynamicQueryParameters":false,"AllowDynamicFormParameters":false,"IsMultiContentStreaming":false,"ErrorTemplates":{},"SkipAdditionalHeaders":false}

``x-unitTests``
    | **String**.
    |[{"request":{"method":"GET","uri":"/dataspaces","headers":{"Authorization":"Bearer IIeDIrdnYo2ngwDQYJKoZIhvcNAQELBQAwSDEZMBcGA1UEAwwQaVNIQ"}},"expectedResponse":{"x-allowExtraHeaders":true,"x-bodyMatchMode":"NONE","x-arrayOrderedMatching":false,"x-arrayCheckCount":false,"x-matchResponseSchema":true,"statusCode":"200","headers":{}},"x-testShouldPass":true,"x-testEnabled":false,"x-testName":"Test RequestdataspacesfromSatellite","x-testDescription":"Request dataspaces from Satellite"}]
