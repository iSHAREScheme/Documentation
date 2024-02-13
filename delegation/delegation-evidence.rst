.. _refDelegationEvidence:

Delegation Evidence
===================

This section describes the iSHARE delegation evidence data model, which is the response to a valid delegation request. The :ref:`Delegation Request section<refDelegationRequest>` describes the request data model which is used in order to receive such response. To see full delegation evidence response example see :ref:`Delegation Response example section<refDelegationResponseExample>`.

``delegationEvidence``
    | **Object**. Root level.
    | The root of any delegation evidence.

    ``notBefore``
        | **Integer**. Contained in ``delegationEvidence``.
        | Unix timestamp in UTC indicating the start of validity period of this delegation evidence. SHOULD equal the time of issuing of the evidence unless historic evidence is requested.

    ``notOnOrAfter``
        | **Integer**. Contained in ``delegationEvidence``.
        | Unix timestamp in UTC indicating the end of validity period of this delegation evidence. It is up to the issuer off the evidence to set this time. Note that a reasonable amount of time SHOULD be allowed for processing of longer delegation paths. Also note that evidence cannot be revoked, so setting very long validity periods SHOULD be avoided.

    ``policyIssuer``
        | **String**. Contained in ``delegationEvidence``.
        | iSHARE identifier of the delegator, also know as the delegating entity.

    ``target``
        | **Object**. Contained in ``delegationEvidence``.
        | MUST for the root level contain an accessSubject. No other elements are allowed. It makes the entire delegation evidence applicable only to this accessSubject.

        ``accessSubject``
            | **Object**. Contained in ``target``.
            | iSHARE identifier of the delegate, also known as the entity that receives the delegated rights. It should be either iSHARE identifier for M2M cases or human pseudonym for H2M cases.

    ``policySets``
        | **Array of Objects**. Contained in ``delegationEvidence``.
        | Container for one or more objects containing policy elements with an indication for further delegation. Note that policySet elements within one delegationEvidence MUST not restrict each other, but rather offer a mechanism to express additional rights. They MUST be evaluated in a *permit-override* manner, allowing a *Permit* if only one of the policySet elements evaluates to *Permit*.
        | :ref:`Data model description and examples can be found at Policy Sets section<refPolicySets>`.

**Example**:

.. code-block:: json

    {
      "delegationEvidence": {
        "notBefore": 1504683475,
        "nonOnOrAfter": 1504683775,
        "policyIssuer": "EU.EORI.NL123456789",
        "target": {
          "accessSubject": "EU.EORI.NL987654321"
        },
        "policySets": [ "object" ]
      }
    }