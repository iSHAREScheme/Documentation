Welcome to iSHARE
=================

iSHARE is a collaborative effort to improve conditions for data-sharing for organisations within as well as across sectors. The iSHARE Trust framework results in a set of agreements which improve circumstances for data exchange.

The ambition of iSHARE is to lower barriers for sharing data, to empower new forms of collaboration in chains and to help scale up existing initiatives that aim to improve conditions for data exchange. The underlying assumption is that if data can flow in a controlled and smart way, it will lead to a more efficient use of infrastructure, less carbon emissions and a more competitive datadriven organisations. 

iSHARE is not a platform. iSHARE from a technical perspective is an identification, authentication & authorization protocol for both machine2machine (M2M) and human2machine (H2M) communication based on a JSON REST API architecture. Authentication is heavily based on Public Key Infrastructure (PKI) and therefore certificates and public / private key pairs. iSHARE relies heavily on signed JSON Web Tokens for protecting the integrity of message content. Every party of iSHARE validates signatures and interpret the content of JWTs. Every party creates and signs these tokens depending on the context.

The iSHARE framework consists of six roles that, depending on the situation, interact with each other based on the iSHARE scheme agreements. Each role has a certain function in the scheme and bears certain responsibilities (read more at our `non so technical documentation <https://ishareworks.atlassian.net/wiki/spaces/IS/pages/70221987/Framework+and+roles>`_. If you are here, perhaps you need to implement the solution for your organization according to iSHARE specific role requirements.

This developer portal provides everything needed to get started with implementing iSHARE for your organization. The open standards used need to be configured towards iSHARE usage. It is therefore essential to familiarize yourself with some technical concepts that are present on Introduction section in order to be able to smoothly implement iSHARE for your organization. Currently there is a `.NET library <https://github.com/iSHAREScheme/iSHARE.NET>`_ which provides core functionality for service consumers.

In order to start the development please read everything until you reach :ref:`Getting Started page<refGettingStarted>`.

.. note:: If you are looking for demo content before getting started with your implementation, such as :ref:`videos<refVideos>` or :ref:`postman collections<refPostman>`, that showcase how iSHARE works technically, head over to the Demo & Testing section!

.. toctree::
   :hidden:
   :caption: Introduction

   introduction/standards
   introduction/jwt
   introduction/help
   introduction/getting-started

.. toctree::
   :hidden:
   :caption: Demo & Testing

   demo-and-testing/postman
   demo-and-testing/videos
   demo-and-testing/test-certificates
   demo-and-testing/test-participants
   demo-and-testing/ctt

.. toctree::
   :hidden:
   :caption: M2M Interaction

   m2m/authentication
   m2m/authorization

.. toctree::
   :hidden:
   :caption: H2M Interaction

   h2m/authentication
   h2m/authorization

.. toctree::
   :hidden:
   :caption: Delegation

   delegation/endpoint
   delegation/delegation-request
   delegation/policy-sets
   delegation/delegation-evidence

.. toctree::
   :hidden:
   :caption: Common Endpoints

   common/token
   common/capabilities

.. toctree::
   :hidden:
   :caption: Scheme Owner Endpoints
   
   scheme-owner/parties-id.rst
   scheme-owner/parties.rst
   scheme-owner/trusted-list.rst
   scheme-owner/versions.rst

.. toctree::
   :hidden:
   :caption: Service Provider Endpoints

   service-provider/return
   service-provider/service

.. toctree::
   :hidden:
   :caption: Identity Provider Endpoints

   identity-provider/authorize
   identity-provider/login
   identity-provider/token
   identity-provider/userinfo
   
.. toctree::
   :hidden:
   :caption: UI Guidelines
   
   ui-guidelines/sign-in
