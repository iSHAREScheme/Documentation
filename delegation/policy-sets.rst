.. _refPolicySets:

Policy Sets
===========

The second level objects in policySets each contain the following parameters. Other parameters are not allowed. Note that XACML spec is heavily restricted, a.o. for the reason to prevent redundancy (and resulting possible conflicts) with the root policySet element.

``maxDelegationDepth``
    | **Integer**. Contained in ``policySets``. *Optional*.
    | Optional element that, if present, indicates that further delegation of the rights, conveyed in the policy elements that are part of this PolicySet, is allowed. The value indicates the delegation steps that are allowed after this step in order to evaluate the entire delegation path to *Permit*.

``target``
    | **Object**. Contained in ``policySets``.
    | Contains ``environment``.

    ``environment``
      | **Object**. Contained in ``target``.
      | Contains ``licenses``.

      ``licenses``
        | **Array of Strings**. Contained in ``environment``.
        | Array which describes which iSHARE licenses apply to this policySet.

``policies``
    | **Array of Objects**. Contained in ``policySets``.
    | Used to express the actual rights for which evidence is being requested. Note that policies within one policySets object MUST not restrict each other, but rather offer a mechanism to express additional rights. They will be evaluated in a *permit-override* manner, allowing a *Permit* if only one of the policy elements evaluates to *Permit*.
    | :ref:`Data model description and examples can be found at Policies section<refPolicies>`.

.. warning:: For Delegation Mask (Delegation Request) only ``policies`` are required. All other parameters should be ignored.

**Example**:

.. code-block:: json

    {
      "policySets": [
        {
          "maxDelegationDepth": 5,
          "target": {
            "environment": {
              "licenses": [ "string" ]
            }
          },
          "policies": [ "object" ]
        }
      ]
    }

.. _refPolicies:

Policies
--------

``target``
    | **Object**. Contained in ``policies``.
    | Describes the target, in terms of resource and action, this request applies to. It is also the scope that is permitted through the default rule.

    ``resource``
        | **Object**. Contained in ``target``.
        | Contains ``type``, ``identifiers`` and ``attributes``.

        ``type``
            | **String**. Contained in ``resource``.
            | String which describes the type of resource to which the rules apply.

        ``identifiers``
            | **Array of Strings**. Contained in ``resource``. *Optional*.
            | Optional array of strings containing one or more resource identifiers.

        ``attributes``
            | **Array of Strings**. Contained in ``resource``. *Optional*.
            | Optional array of attributes of the resources the delegated rights apply to.

    ``actions``
        | **Array of Strings**. Contained in ``target``.
        | Array of actions that apply to this policy.

    ``environment``
        | **Object**. Contained in ``target``. *Optional*
        | Optional field that contains ``serviceProviders``.

        ``serviceProviders``
            | **Array of Strings**. Contained in ``environment``. *Optional*
            | Array which lists the iSHARE client ID's of serviceProviders which are allowed to provide services to the accessSubject as described within this policy.

``rules``
    | **Array of Objects**. Contained in ``policies``.
    | The first rule element is the default rule that applies to the target at policies level. Note that additional rule elements within one policies object are intended to restrict each the default rule. All rule elements in a Policy will be evaluated in a *deny-override* manner, allowing a *Permit* only if all of the rule elements evaluate to *Permit*.
    | :ref:`Data model description and examples can be found at Rules section<refRules>`.

**Example**:

.. code-block:: json

    {
      "policies": [
        {
          "target": {
            "resource": {
              "type": "CONTAINER.DATA",
              "identifiers": [
                "ID.12345"
              ],
              "attributes": [
                "CONTAINER.ETA"
              ]
            },
            "actions": [
              "iSHARE.READ"
            ],
            "environment": {
              "serviceProviders": [
                "EU.EORI.NL567891234"
              ]
            }
          },
          "rules": [ "object" ]
        }
      ]
    }

.. _refRules:

Rules
-----

The default rule element contains the following parameter:

``effect``
    | **String**. Contained in ``rules``.
    | Value must be equal to *Permit*.

----

Additional rule elements contains the following parameters. Although individually not required, at least one type, identifier or attribute MUST be specified to which additional rules apply:

``effect``
    | **String**. Contained in ``rules``.
    | Value must be equal to *Deny*.

``target``
    | **Object**. Contained in ``policies``.
    | Describes the target, in terms of resource and action, this additional rule applies to. Additional rule elements are limitations of the default rule and resource scope.

    ``resource``
        | **Object**. Contained in ``target``.
        | Contains ``type``, ``identifiers`` and ``attributes``.

        ``type``
            | **String**. Contained in ``resource``. *Optional*.
            | String which describes the type of resource to which the rules apply. Defaults to none if not specified.

        ``identifiers``
            | **Array of Strings**. Contained in ``resource``. *Optional*.
            | Optional array of strings containing one or more resource identifiers. Depending on the type an identifier SHOULD be a URN.

        ``attributes``
            | **Array of Strings**. Contained in ``resource``. *Optional*.
            | Optional array of attributes of the resources the delegated rights apply to. If omitted defaults to all attributes. Depending on the type an attribute SHOULD be a URN.

    ``actions``
        | **Array of Strings**. Contained in ``target``. *Optional*.
        | Array of actions that apply to this policy. If no actions are listed then the default is to all iSHARE actions defined within the policy.

**Example**:

.. code-block:: json

    {
      "rules": [
        {
          "effect": "Permit"
        },
        {
          "effect": "Deny",
          "target": {
            "resource": {
              "type": "CONTAINER.DATA",
              "identifiers": [
                "ID.12378",
                "ID.12379"
              ],
              "attributes": [
                "CONTAINER.WEIGHT"
              ]
            }
          }
        }
      ]
    }