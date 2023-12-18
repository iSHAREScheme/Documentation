Welcome to iSHARE Developer Portal
==================================

iSHARE is a collaborative effort to improve conditions for data-sharing for organisations within as well as across sectors. The iSHARE Scheme results in a set of agreements which improve circumstances for data exchange.

The ambition of iSHARE is to lower barriers for sharing data, to empower new forms of collaboration in chains and to help scale up existing initiatives that aim to improve conditions for data exchange. The underlying assumption is that if data can flow in a controlled and smart way, it will lead to a more efficient use of infrastructure, less carbon emissions and a more competitive datadriven organisations. 

Traditionally, a software infrastucure is created to facilitate organisations to a standardised and controlled data exchange where iSHARE deviates from it and rather provides "soft infrastructure". iSHARE from a technical perspective is an identification, authentication & authorization protocol for both machine2machine (M2M) and human2machine (H2M) communication based on REST API architecture. Authentication is heavily based on Public Key Infrastructure (PKI) and therefore certificates and public / private key pairs. iSHARE relies heavily on signed JSON Web Tokens for protecting the integrity of message content. Every party of iSHARE validates signatures and interpret the content of JWTs. Every party creates and signs these tokens depending on the context.

Every data sharing transaction must be mapped to iSHARE role model. The iSHARE framework consists of six roles that, depending on the situation, interact with each other based on the iSHARE scheme agreements. Each role has a certain function in the scheme and bears certain responsibilities (read more at our `non so technical documentation <https://ishareworks.atlassian.net/wiki/spaces/IS/pages/70221987/Framework+and+roles>`_. If you are here, perhaps you need to implement the solution for your organization according to iSHARE specific role requirements.

This developer portal provides everything needed to get started with implementing iSHARE for your organization. The open standards used need to be configured towards iSHARE usage. It is therefore essential to familiarize yourself with some technical concepts that are present on Introduction section in order to be able to smoothly implement iSHARE for your organization. For reference implementations and opensource components compliant with iSHARE spifications please refer to our `GitHub  <https://github.com/iSHAREScheme/>`_ .

In order to start the development please read everything until you reach :ref:`Getting Started page<refGettingStarted>`.

.. note:: If you are looking for demo content before getting started with your implementation, such as :ref:`videos<refVideos>` or :ref:`postman collections<refPostman>`, that showcase how iSHARE works technically, head over to the Demo & Testing section!

.. toctree::
   :hidden:
   :caption: Introduction

   introduction/getting-started
   introduction/help

.. toctree::
   :hidden:
   :caption: Reference

   reference/standards
   reference/jwt
   reference/videos
   reference/m2m/authentication
   reference/m2m/authorization

.. toctree::
   :hidden:
   :caption: Demo & Testing

   demo-and-testing/postman
   demo-and-testing/test-certificates
   demo-and-testing/test-participants
   demo-and-testing/ctt

.. toctree::
   :hidden:
   :caption: Conformance Testing

   demo-and-testing/ctt

.. toctree::
   :hidden:
   :caption: iSHARE Satellite Role

   common/token
   satellite/parties.rst
   satellite/trusted-list.rst
   satellite/versions.rst
   common/capabilities
   satellite/dataspaces
   
.. toctree::
   :hidden:
   :caption: Authorisation Registry Role

   common/token
   delegation/endpoint
   delegation/delegation-request
   delegation/policy-sets
   delegation/delegation-evidence
   common/capabilities

.. toctree::
   :hidden:
   :caption: Service Provider Role

   common/token
   service-provider/return
   service-provider/service
   common/capabilities

.. toctree::
   :hidden:
   :caption: Identity Provider Role

   identity-provider/authorize
   identity-provider/login
   identity-provider/token
   identity-provider/userinfo
   common/capabilities

.. toctree::
   :hidden:
   :caption: Common Endpoints

   common/token
   common/capabilities

.. toctree::
   :hidden:
   :caption: UI Guidelines
   
   ui-guidelines/sign-in
