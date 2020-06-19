Authentication
==============

Besides Machine2Machine interaction, it can occur that it is relevant if a specific person requests data or a service. In order to provide a Service Provider with identity information about a human subject, iSHARE uses the OpenID Connect 1.0 protocol.

The iSHARE use of OpenID Connect 1.0 is based on the requirements from the `official standard <https://openid.net/specs/openid-connect-core-1_0.html>`_. In addition to the OpenID Connect 1.0 specification, the following requirements apply:

* Clients (a.ka.a. service providers) MUST NOT be pre-registered. A look-up in the iSHARE adherence registry is sufficient. It is up to the server to create a new entry for Clients that perform requests for the first time.
* The client_id MUST contain the valid iSHARE identifier of the client.
* Servers SHALL NOT issue refresh tokens.

Generic Authentication Flow
---------------------------

Based on the described standards and specifications in this scheme, the generic iSHARE Human2Machine Authentication flow is described in the following sequence diagram.

.. image:: resources/H2M-portal.png

The sequence diagram shows how the Service Provider interacts with an Identity Provider in order to receive identity information on the human user (who uses a browser to interact with the Service Provider). The specific details of the steps in this authentication flow are described in the generic API documentation of iSHARE:

1. :ref:`/identity_provider/authorize<refAuthorizeEndpoint>`
2. :ref:`/service_provider/openid_connect1.0/return<refReturnEndpoint>`
3. :ref:`/identity_provider/token<refIDPTokenEndpoint>`
4. :ref:`/identity_provider/userinfo<refUserInfoEndpoint>`

A few remarks regarding this flow:

* Human user might interact with Service Provider in a different way than using a web browser.
* After the Service Provider initiates a POST /token request, the Identity Provider can verify their iSHARE Adherence with the Scheme Owner. Adherence checks or certificate validation is not displayed in this flow as this flow only describes the generic OpenID Connect 1.0 flow
* This flow only describes Identification & Authentication of a human user, while in iSHARE it is always relevant that their Authorization (acting on behalf of an organization) is also verified. This process is described in the :ref:`Human Authorization section<refH2MAuthorization>`.