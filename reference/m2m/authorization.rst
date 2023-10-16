.. _refM2MAuthorization:

Authorization
=============

A core functionality of iSHARE is managing authorizations, either on an organisational level or on a personal level. Read more on the background of iSHARE Authorisations in the `iSHARE Scheme <https://ishareworks.atlassian.net/wiki/spaces/IS/pages/70222169/Facilitate+flexible+authorizations+applicable+in+any+context>`_.

Within iSHARE, participants can request so-called *delegation evidence* from either an Entitled Party or one of the Authorization Registries. In order to receive this evidence, various rules need to be followed:

* An organisation can only request evidence for an Authorization policy that concerns this organisation. The organisation is either the creater or *issuer* of the policy, or is the subject to which the policy applies.
* The only exception to the previous rule occurs when a Service Provider needs to gather delegation evidence for a client. The Service Provider needs to pass a valid *client_assertion* of this client to the Entitled Party / Authorization Registry. This proves that this client is indeed *at the gate of the Service Provider* and it is necessary to ask about his authorizations.
* Such a *client_assertion* should be passed through the *previous_steps* array in the *delegation_mask*. The *delegation_mask* is the body of the request to the :ref:`/delegation endpoint<refDelegationEndpoint>` of an Authorization Registry. The *client_assertion* is always necessary if a Service Provider is not listed as issuer or subject of the delegation.
* iSHARE only specifies what the request and response data structure of delegation evidence looks like. iSHARE does not prescribe what the input and database storage for authorization looks like. The `/policy endpoint <https://ar.isharetest.net/swagger/index.html#/Policy/post_policy>`_ of the AskMeAnything AR is not standardized in iSHARE and only an example of how authorizations can be stored at an AR.