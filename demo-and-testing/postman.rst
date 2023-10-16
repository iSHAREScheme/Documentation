.. _refPostman:

Postman Collections
===================

This section contains various Postman collections, which can be used to manually test iSHARE APIs. In these collections, you as a user are impersonating Test participant ‘ABC Trucking’.

In order to impersonate ABC Trucking, these Postman collections contain the private key of ABC Trucking. For non-dummy parties, private keys should never be shared with the Scheme Owner or other iSHARE Parties

Each collection contains all API endpoints of a specific Test participant, and as ABC Trucking you are able to consume these API endpoints.

Downloads
---------

In order for the collections to work, please download iSHARE :download:`environment <resources/postman/190509A_iSHARE_Test_Environment.postman_environment.json>` and :download:`globals <resources/postman/190312A_iSHARE_Globals.postman_globals.json>`. Then download the following Postman collections:

* :download:`ABC Trucking and the Scheme Owner <resources/postman/190509A_iSHARE_Test_-_ABC_Trucking_and_Scheme_Owner.postman_collection.json>`
* :download:`ABC Trucking and Warehouse 13 <resources/postman/190509A_iSHARE_Test_-_ABC_Trucking_and_Warehouse13.postman_collection.json>`
* :download:`ABC Trucking and the Authorization Registry <resources/postman/190312A_iSHARE_Test_-_ABC_Trucking_and_Authorization_Registry.postman_collection.json>`
* :download:`ABC Trucking and Awesome Widgets <resources/postman/190312A_iSHARE_Test_-_ABC_Trucking_and_Awesome_Widgets.postman_collection.json>`
* :download:`End-2-End flow: ABC Trucking gets container data from Warehouse 13 (Service Provider requests Delegation Evidence) <resources/postman/190509A_iSHARE_E2E-_M2M_1a__SP_requests_DE_.postman_collection.json>`
* :download:`End-2-End flow: ABC Trucking gets container data from Warehouse 13 (Service Consumer provides Delegation Evidence) (Service Provider requests Delegation Evidence) <resources/postman/190509A_iSHARE_E2E-_M2M_1b__SC_provides_DE_.postman_collection.json>`

Instructions
------------

To request an access token:

* Open the /token request
* The client_assertion is generated in the background
* Run the request without making additional changes, the response should contain (among others) an access token value

To request a service:

* Open a service request
* The access token is automatically copied.
* Run the request, the response should contain (an encoded) response
* If the response is encoded, decode the token via `jwt.io <https://www.jwt.io>`_ and inspect the results

.. tip:: For /delegation service requests please view the demo in the :ref:`next section<refVideos>`, this will explain how authorization in iSHARE can work and Postman examples are shown.