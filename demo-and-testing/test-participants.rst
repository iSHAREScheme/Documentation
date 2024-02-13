.. _refTestParticipants:

Test Participants
=================

ABC Trucking
------------

Test implementation of a pure service consuming iSHARE participant. ABC Trucking does not expose any service, they only consume services.

* **EORI / iSHARE identifier**: EU.EORI.NL000000001
* :download:`ABC Trucking.pem<resources/participants/ABCTruckingCert.pem>`
* :download:`ABC Trucking.der<resources/participants/ABCTrucking.der>`

iSHARE Satellite
----------------

Test implementation of the iSHARE Satellite. The Satellite maintains a database of active iSHARE participants

* **EORI / iSHARE identifier**: EU.EORI.NL000000000
* **API Endpoint base URL**: https://sat-mw.uat.isharetest.net
* **OpenAPI Specification**: `Satellite Swagger <https://app.swaggerhub.com/apis/iSHARE/i-share_satellite/>`_
* :download:`Scheme Owner.pem <resources/participants/iSHARESchemeOwner.pem>`

.. note:: ``/certificate_validation``, ``/me``, ``/testing/generate-jws``, ``/testing/generate-authorize-request`` endpoints in Swagger UI are not a part of the official iSHARE specification. They are provided for additional test functionality only. Therefore, it is unavailable in production environment.

Warehouse 13
------------

Test implementation of an iSHARE Service Provider. Besides the required /token and /capabilities endpoints, Warehouse 13 exposes different services under iSHARE.

* **EORI / iSHARE identifier**: EU.EORI.NL000000003
* **API Endpoint base URL**: https://w13.isharetest.net
* **OpenAPI Specification**: `W13 Swagger UI <https://w13.isharetest.net/swagger>`_
* :download:`Warehouse 13.pem <resources/participants/Warehouse13.pem>`

.. note:: ``/me``, and ``/boom_access`` endpoints in Swagger UI are neither a part of the official iSHARE specification nor a W13 business logic specific endpoints. They are provided for additional test functionality only.

Awesome Widgets
---------------

Test implementation of an iSHARE Service Provider. Besides the required /token and /capabilities endpoints, Awesome Widgets exposes different services under iSHARE.

* **EORI / iSHARE identifier**: EU.EORI.NL000000002
* **API Endpoint base URL**: https://awesome.isharetest.net
* **OpenAPI Specification**: `AW Swagger UI <https://awesome.isharetest.net/swagger>`_
* :download:`Awesome Widgets.pem <resources/participants/AwesomeWidgets.pem>`

.. note:: ``/me``, and ``/boom_access`` endpoints in Swagger UI are neither a part of the official iSHARE specification nor an AW business logic specific endpoints. They are provided for additional test functionality only.

Banana & Co
-----------

Test implementation of an Entitled Party. Besides being a resource owner across many systems, Banana & Co also provides the possibility to manage authorization in their systems. Just as an Authorization Registry, this Entitled Party provides a /delegation endpoint.

* **EORI / iSHARE identifier**: EU.EORI.NL000000005
* **API Endpoint base URL**: https://banana.isharetest.net
* **OpenAPI Specification**: `B&C Swagger UI <https://banana.isharetest.net/swagger>`_
* :download:`Banana & Co.pem <resources/participants/BananaAndCo.pem>`
* **UI for policies management**: https://banana.isharetest.net/admin

.. note:: ``/me`` endpoint in Swagger UI are neither a part of the official iSHARE specification nor a B&C business logic specific endpoints. They are provided for additional test functionality only.

.. tip:: If you need to test against this Entitled Party's delegation endpoint, please contact us at support@ishare.eu and we will issue an account for you in order to access the UI.

Authorization Registry
----------------------

Test implementation of an Authorisation Registry. Users can get an account for the Authorisation Registry, so they can manage some dummy policies for testing authorisation flows.

.. warning:: This is merely a tool for testing and as such not fit for production/live situations. The Registry gives an idea of what an Authorisation Registry could look like, but the entire user interface is not mandatory.

* **EORI / iSHARE identifier**: EU.EORI.NL000000004
* **API Endpoint base URL**: https://ar.isharetest.net
* **OpenAPI Specification**: `AR Swagger UI <https://ar.isharetest.net/swagger>`_
* :download:`Authorization Registry.pem <resources/participants/AuthorizationRegistry.pem>`
* **UI for policies management**: https://ar.isharetest.net/admin

.. note:: ``/me`` and ``/policy`` endpoints in Swagger UI are not a part of the official iSHARE specification. They are provided for additional test functionality only.

.. tip:: If you need to test against this Authorization Registry's delegation endpoint, please contact us at support@ishare.eu and we will issue an account for you in order to access the UI.