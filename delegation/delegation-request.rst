.. _refDelegationRequest:

Delegation Mask
===============

This section describes the iSHARE delegation request data model used in a valid request for delegation evidence response. The :ref:`Delegation Evidence section<refDelegationEvidence>` describes the response data model to delegation request. To see full delegation request example please visit :ref:`Delegation Endpoint response example section<refDelegationResponseExample>`.

.. note:: Visit :ref:`delegation endpoint section<refDelegationEndpoint>` to read API documentation that specifies how the ``/delegation`` endpoint should look like since delegation mask is not enough for full flow to work.

``delegationRequest``
    | **Object**. Root level.
    | The request for any delegation evidence.

    ``policyIssuer``
        | **String**. Contained in ``delegationRequest``.
        | iSHARE identifier of the delegator (the delegating entity).

    ``target``
        | **Object**. Contained in ``delegationRequest``.
        | MUST for the root level contain an ``accessSubject``. No other elements are allowed. It makes the entire delegation evidence applicable only to this accessSubject.

        ``accessSubject``
            | **String**. Contained in ``target``.
            | iSHARE identifier of the delegate, also known as the entity that receives the delegated rights.

    ``policySets``
        | **Array of Objects**. Contained in ``delegationRequest``.
        | Container for one or more objects containing policy elements with an indication for further delegation. Note that policySet elements within one delegationRequest MUST not restrict each other, but rather offer a mechanism to express additional rights. They will be evaluated by the Authorization Registry in a *permit-override* manner, allowing a *Permit* if only one of the policySet elements evaluates to *Permit*.
        | :ref:`Data model description and examples can be found at Policy Sets section<refPolicySets>`.

    ``delegation_path``
        | **Array of Strings**. Root level. *Optional*. 
        | Container for one or more iSHARE identifiers values for a situation where multiple delegation policies need to be linked together.

    ``previous_steps``
        | **Array of Strings**. Root level. *Optional*.
        | Container for one or more pieces of evidence such that the client has legitimate reason to request delegation evidence. A single step contains either a previous delegationEvidence statement or a client_assertion. The minimum is a client_assertion value of the accessSubject, for example if the Service Provider requests ``delegationEvidence`` for an authorization in which he is neither the policyIssuer or the accessSubject.

**Example:**

.. code-block:: json

    {
      "delegationRequest": {
        "policyIssuer": "EU.EORI.NL123456789",
        "target": {
          "accessSubject": "EU.EORI.NL987654321"
        },
        "policySets": [ "object" ]
      },
      "delegation_path": [ "string" ],
      "previous_steps": [ "string" ]
    }