.. _refGettingStarted:

Getting Started
===============

Before getting started it is highly recommended to familiarize yourself with essentials of iSHARE that are described in introduction section.

You need to apply for an iSHARE Test certificate in order to use our test environment. How to do that is described at :ref:`Get Test Certificate section<refGetTestCert>`.

.. _refConsumeISHARE:

Consuming iSHARE Services
-------------------------

Creating JSON Web Tokens
~~~~~~~~~~~~~~~~~~~~~~~~

Familiarize yourself with JWT, JWS, and how to create/sign these tokens. Find various libraries and additional information for JSON Web Tokens on `jwt.io <https://jwt.io>`_.

Various requests or responses that follow the iSHARE specifications contain signed JSON Web Tokens. Start by creating a self-signed identity claim, a *client_assertion*, following the specifications found on the :ref:`iSHARE JWT section<refJWT>`:

1. Construct the correct JWT header.
2. Construct the required JWT payload.
3. Sign token according to JWS specifications.

.. tip:: Take into account that iSHARE compliant JWT is going be used almost everywhere. Make sure that the code you write could be easily extendeded according to specific JWT payload requirements. 

Get an OAuth 2.0 Access Token
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first workflow you should implement is an OAuth access token request. The wider use case of it is described on :ref:`M2M Authentication section<refM2MAuthentication>`.

1. Choose a test party from the :ref:`iSHARE Test environment<refTestParticipants>` and create a *client_assertion* with the correct audience.
2. Head over to :ref:`Token Endpoint section<refM2MToken>` to see the contract of /token endpoint HTTP request.
3. Implement a token request according to contract.
4. If done correctly, the test party should respond with an access token.

.. note:: A video demonstrating how access tokens are requested in iSHARE can be found at :ref:`Videos section<refGetAccessTokenDemo>`. In order to try it out with existing parties, please visit :ref:`Postman Collections section<refPostman>`.

Request Services With Access Tokens
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Choose a test party from the :ref:`iSHARE Test environment<refTestParticipants>` that exposes a service, with access control based on the access token. E.x. :ref:`/capabilities<refCapabilitiesEndpoint>` is not restricted to additional authorization requirements.
2. Get an access token which you've implemented based on the previous section.
3. Provide the access token as specified in the documentation as an authorization header.
4. If done correctly, the test party should respond with the service that is requested.

Exposing iSHARE services
------------------------

Before exposing any of iSHARE services, firstly you should have a proper implemention of :ref:`iSHARE services consumption<refConsumeISHARE>`. It is needed in order to retrieve an access token from the iSHARE Satellite or other iSHARE parties. 

Certificate Validation
~~~~~~~~~~~~~~~~~~~~~~

Familiarize yourself with PKI, certificates and how the process of certificate validation works. iSHARE has a *certificate cheat sheet*, :download:`check it out <resources/181113iSHARE_Certificate_cheat_sheet_v1.pdf>`.

1. Implement a function that retrieves the trusted list of Certificate Authorities from the iSHARE Satellite :ref:`/trusted_list endpoint<refTrustedList>`.
2. Implement a service that can validate certificates within the scope of iSHARE (see :ref:`Certificate Validation<refCertificateValidation>`. Implemented service should check validity of certificate itself (such as expiry date, signature, CRL) and whether the certificate issuer is on the trusted list of iSHARE.

.. note:: iSHARE has example projects and code snippets on GitHub, it also contains certificate validion, `check it out <https://github.com/iSHAREScheme>`_.

Expose Access Token Endpoint
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to be a party of iSHARE your system must expose an API service that allows parties to request OAuth access tokens from your server. iSHARE does not prescribe your exact implementation or access token format, but your system should be able to handle requests send as described in the ``/token`` request from the iSHARE specifications.

1. For incoming token requests, make sure that they comply with the specified iSHARE :ref:`token requests<refM2MToken>`.
2. Validate the certificate used for this request. It is in a JWT header of ``client_assertion``.
3. Send the client’s iSHARE ID or EORI (found as ``subject`` within the request’s ``client_assertion``) plus the certificate's ``subject_name`` to the iSHARE Satellite :ref:`/parties endpoint<refParties>` for status check. Response for party status should be equal to *Active*.
4. If the party is *Active*, respond to their request with an access token, else with Bad Request.

.. note:: Sequence diagram of this flow can be found at :ref:`Generic Authentication Flow section<refM2MTokenFlow>`.

Expose Capabilities Endpoint
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To allow other parties to know what your party is capable of, capabilities endpoint must be implemented. Participants of iSHARE will use this endpoint to see what iSHARE enabled services your organization provides. Implementation is pretty straightforward and API endpoint specification can be found at :ref:`Capabilities Endpoint section<refCapabilitiesEndpoint>`. 

Additional Authorization
------------------------

Services that require additional *evidence* for authorized access can make use of the :ref:`iSHARE authorization protocol<refM2MAuthorization>`. This section should be interesting mostly for Authorization Registries, Service Providers and Entitled Parties.

Firstly you will have to familiarize yourself with iSHARE :ref:`delegation mask<refDelegationRequest>` and :ref:`delegation evidence<refDelegationEvidence>` data models.

Understanding Delegation Mask
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the :ref:`/delegation endpoint API specification<refDelegationEndpoint>` of the Authorization Registry or Entitled Party. The request body contains a :ref:`delegation mask<refDelegationRequest>`, which is in other words could be called the actual question that is asked, the *question* contains:

* Two parties between which a certain right is passed.
* Resource fields that are used to specify the resource or service for which delegation evidence is requested.
* Action field to indicate the kind of action regarding the resource is expected.

.. note:: You can find a video with an explanation how delegation mask is used within Auhorization Registry in :ref:`Videos section<refARVideo>`.

Creating Delegation Mask
~~~~~~~~~~~~~~~~~~~~~~~~

In order to create :ref:`delegation mask<refDelegationRequest>` (a.k.a. the *question*), you need to translate an incoming Service Request. Through the Service Request, you should be able to:

* Define which party is asking for an access to a resource or service.
* Indicate the second party that is needed for the mask. Your system’s knowledge of ownership of this resource of service should be able to fill this information.
* Define the resource or service itself (as long as it is clear through the Service Request).
* Indicate what kind of action is expected.

Once the *delegation mask* (a.k.a. the *question*) is created, a request towards /delegation endpoint of Authorization Registry or Entitled party should be sent.

Interpreting Delegation Evidence
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Delegation evidence will be :ref:`iSHARE compliant JWT<refJWT>` which contains JWT payload described at :ref:`delegation evidence section<refDelegationEvidence>`. Based on JWT information, an authorization decision should be made and enforced to the client.

What's Next?
------------

After implementing of what is described above you will have to implement endpoints which are required specifically for your organization. Endpoints could be found in the right menu, under your organization's role title. Once that is done, you will have to pass :ref:`Conformance Test Tool<refCTT>`.

In order to double check if required endpoints are implemented, please use the following list as a cheat sheet:

Authorization Registry
    | :ref:`Access Token<refM2MToken>`
    | :ref:`Capabilities<refCapabilitiesEndpoint>`
    | :ref:`Delegation<refDelegationEndpoint>`

Entitled Party
    | :ref:`Access Token<refM2MToken>`
    | :ref:`Capabilities<refCapabilitiesEndpoint>`
    | :ref:`Delegation<refDelegationEndpoint>`

Identity Provider
    | :ref:`Access Token (M2M)<refM2MToken>`
    | :ref:`Capabilities<refCapabilitiesEndpoint>`
    | :ref:`Authorize<refAuthorizeEndpoint>`
    | :ref:`Login<refIDPLogin>`
    | :ref:`Access Token (H2M)<refIDPTokenEndpoint>`
    | :ref:`User Info<refUserInfoEndpoint>`

Service Provider
    | :ref:`Access Token<refM2MToken>`
    | :ref:`Capabilities<refCapabilitiesEndpoint>`
    | :ref:`Return<refReturnEndpoint>`
    | :ref:`Service<refServiceEndpoint>` (if party is a Service Provider, it is expected that it would provide at least one service)