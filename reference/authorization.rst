.. _refAuthorization:

Authorization
=============


.. _refM2MAuthorization:

Machine to Machine (M2M) Authorization
======================================

A core functionality of iSHARE is managing authorizations, either on an organisational level or on a personal level. Read more on the background of iSHARE Authorisations in the `iSHARE Scheme <https://framework.ishare.eu/is/facilitate-flexible-authorizations-applicable-in-a>`_.

Within iSHARE, participants can request so-called *delegation evidence* from either an Entitled Party or one of the Authorization Registries. In order to receive this evidence, various rules need to be followed:

* An organisation can only request evidence for an Authorization policy that concerns this organisation. The organisation is either the creater or *issuer* of the policy, or is the subject to which the policy applies.
* The only exception to the previous rule occurs when a Service Provider needs to gather delegation evidence for a client. The Service Provider needs to pass a valid *client_assertion* of this client to the Entitled Party / Authorization Registry. This proves that this client is indeed *at the gate of the Service Provider* and it is necessary to ask about his authorizations.
* Such a *client_assertion* should be passed through the *previous_steps* array in the *delegation_mask*. The *delegation_mask* is the body of the request to the :ref:`/delegation endpoint<refDelegationEndpoint>` of an Authorization Registry. The *client_assertion* is always necessary if a Service Provider is not listed as issuer or subject of the delegation.
* iSHARE only specifies what the request and response data structure of delegation evidence looks like. iSHARE does not prescribe what the input and database storage for authorization looks like. The `/policy endpoint <https://ar.isharetest.net/swagger/index.html#/Policy/post_policy>`_ of the AskMeAnything AR is not standardized in iSHARE and only an example of how authorizations can be stored at an AR.


.. _refH2MAuthorization:

Human to Machine (H2M) Authorization
====================================

Besides authorization on an organisational level, within iSHARE it is also possible to authorize humans to act on behalf of another organisation. The generic OpenID Connect 1.0 flow does not take into account Authorizations of a human. However, in iSHARE it is essential that authorizations of a user are combined with their identity details before a service can be offered.

Within iSHARE, authorizations of a human are registered at an Identity Provider, and are retrieved using the :ref:`userinfo endpoint<refUserInfoEndpoint>`. For this purpose, there are some modifications to the OpenID Connect Flow. User identities are protected by sharing pseudonyms in order to comply with privacy requirements. Authorization of a human is done by replacing the 'accessSubject' value on the root level in delegationEvidence with an :ref:`iSHARE pseudonym of the human user<refHumanPseudonym>`.

In some cases, it is necessary to encrypt JWTs. The `JWE specification <https://tools.ietf.org/html/rfc7516>`_ is introduced for this. This is necessary in order to prevent unsuspecting users or Identity Brokers from being able to read and infer data not meant for them.

Broadly, user's interaction with the service provider can happen in 2 ways:

:ref:`The service specific approach<refServiceSpecificApproach>`.
    The user has the specific link to a specific service and is only interested in using that service. The service provider only needs to check if the human user is authorized to access this service.
:ref:`The portal approach<refPortalApproach>`.
    The user uses a portal to access a service. The Service Provider needs to know the authorizations of the user in order to only show services available to the user.

.. _refServiceSpecificApproach:

Service Specific Approach
-------------------------

In the service specific approach, the Service Provider will ask for a specific authorization of the human user in the request parameter of the :ref:`userinfo endpoint<refUserInfoEndpoint>`. This request closely follows the :ref:`delegation mask specification<refDelegationRequest>`. However, the value for the ``accessSubject`` on the root level of the delegationEvidence is replaced with the :ref:`iSHARE pseudonym of the human user<refHumanPseudonym>`

.. image:: h2m/resources/H2M-specific.png

.. _refPortalApproach:

Portal approach
---------------

In the portal approach, the Service Provider is allowed to do a wildcard request in the request parameter of the userinfo endpoint. This request closely follows the :ref:`delegation mask specification<refDelegationRequest>`. However, the value for the ``accessSubject`` on the root level of the delegationEvidence is replaced with the :ref:`iSHARE pseudonym of the human user<refHumanPseudonym>` The wildcard is allowed because the Service Provider needs to know all the authorizations of the human user in order to show them in the portal, before the human user can select the correct service. Since a human user would be representing only one company at a time, it is asker by the IDP to select the company it wants to represenent when the user identity is common for different companies it can represent.

.. image:: h2m/resources/H2M-portal.png