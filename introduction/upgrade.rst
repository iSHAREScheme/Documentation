.. _refupgrade:

Upgrade
=======

With release of v2.0 of iSHARE scheme a number of changes are bought to the participants of iSHARE. Mostly the changes are about (technically) federating the participant onboarding process and introduction of Data Spaces concept. Kindly refer to the `Scheme v2.0 <https://framework.ishare.eu/is/?l=en>`_ for more information on the non technical changes done to the scheme.

On this page we describe the technical changes that participants will face due to v2.0 and how they can plan their migration. But first lets list what has changed:

* Introduction of Satellite role (replacing the Scheme Owner for the participant administration part)
* Introduction of Data Spaces


iSHARE Satellite Role
---------------------

Participant registration now can be done by any organisation playing the role of iSHARE satellite. Additionally, now more information about a participant is registered and is made available via the APIs. Though utmost care has been taken to keep changes backwards compatible, not all changes may have been backwards compatible.

In terms of APIs from Scheme Owner to Satellite following is the status of their changes:

* */connect/token* -- no change
* */capabilities* -- no change
* */parties* -- updated with new additional information. **Certifications** attribute is renamed to **roles**. For more details :ref:`refer to API spec<refParties>`
* */party* -- is removed as per the deprication warning. The same functionality is available in /parties endpoint
* */trusted-list* -- no change
* */versions* -- no change
* */dataspaces* -- new endpoint listing all the registered Data Spaces details :ref:`Refer the API spec<refDataspaces>`
* */ep_creation* -- new endpoint allowing satellites to create an Entitled Party programatically via API based on their validation and proof from certified Identity Provider. Note, this API is only for creating Entitled Party without PKI certificate

Migrating to new backend
~~~~~~~~~~~~~~~~~~~~~~~~

To prepare for migration from old backend to new backend following changes in /parties endpoint must be considered.

* Change of **Certifications** attribute to **Roles** attribute.
* Additional attributes are now also added, however, as per the spec the implementation should ignore the additional attributes, so it is expected to be backwards compatible. Please refer to the API specs for details of attributes that are now avaialble via /parties endpoint and adapt your code to consider them if needed.
* Now parties information also contains the x5c value of the PKI certificate which can be used in matching the certificate received in  client_assertion from the requestor. Updated authentication process could be found :ref:`M2M Authentication<refM2MAuthentication>`
 

Process for migration
~~~~~~~~~~~~~~~~~~~~~

Once you have familiarised wiht the changes and prepared for changes on your end, you may want to register your organisation and other organisations in test environment, if not done so already:

1. Provide a test certificate along with (test) EORI for registering in test satellite. In case you do not have a test certificate, you can request one at `our test CA <https://ca7.isharetest.net:8442/ejbca/ra>`_
2. Make the changes in your code and test them in the test network with other parties or using dummy parties.
3. Publish your changes and reqest for conformance testing. :ref:`Details<refCTT>`.
4. When passed, make sure that you submit the CTT results and PKI certificate for registering your organisation in the production environment by sending a request to support@ishare.eu. 

.. note:: In order to provide continutiy iSHARE Foundation will still register participants on production satellite run by the foundation. If participants wish to register themselves via other satellites they are free to do so.

