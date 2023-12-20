.. _refCTT:

Conformance Test Tool
=====================

The Conformance Test Tool (CTT) enables users to perform automated tests on their API services. To be allowed to join the production environment of the iSHARE Network, parties will need to pass all test cases that apply to their role in the iSHARE Network. The CTT will show you per test case whether you passed or failed the case.

To be able to join the iSHARE network in the production environment, you are required to pass a full test run for your specific role in the network. If you have passed the test run for your specific role, please notify us of this at support@ishare.eu with the identifier of your test run.

Portal
------

Users can login to the CTT at `admin portal <https://ctt.isharetest.net/admin>`_ and run a set of test cases on their API services. In order to login please request an account at support@ishare.eu. Key functionalities what users of the Conformance Test Tool can do: 

* Run the full test run for a specific role in the iSHARE Network (i.e. Service Provider or Authorization Registry) on your API services;
* Run a test run on your specific API Service (i.e. /token or /delegation);
* Run a specific test case on your API Service.

After logging in to the Conformance Test Tool, users will be able to configure the endpoints of their API services and will be able to run the test cases on API services themselves. After a test run completes, users will receive the results of a test run in the CTT. The results will display if you have passed the tests, or if not, what test cases failed, and why. User interface is made in a such way that it will be easy to understand for anyone what test cases have passed and failed and why. However, some test cases consists of multiple steps, so in order to understand which exact step has failed detailed logs are needed. CTT provides raw JSON step by step dumps for completed test runs, but it those logs might be too technical for business people or non technical IT specialists to read. If your service fails at least one test case, it is not yet conforming to the iSHARE standards as specified in the scheme and on the developer portal.

Test Case Specifications
------------------------

The API services that need to conform to iSHARE standards differ per party role in the iSHARE Network. Different roles in the iSHARE Network require different sets of test cases as is detailed below. Below is only list of required endpoints, the full list of test cases per API service can be found at `CTT test cases page <https://ctt.isharetest.net/admin/test-cases>`_. 

.. note:: The Conformance Test Tool can only check if you validate test-certificates correctly. It is your responsibility to validate PKI certificates correctly. To learn more please read :ref:`Certificate Validation<refCertificateValidation>` section.

**Service Consumers**

* The Service Consumer does not necessarily host API services. The only requirement is to be able to get a valid access token from the iSHARE Satellite.

**Service Providers**

* The /token endpoint MUST be conforming to the iSHARE standards;
* The /capabilities endpoint MUST be conforming to the iSHARE standards.

**Authorization Registries**

* The /token endpoint MUST be conforming to the iSHARE standards;
* The /capabilities endpoint MUST be conforming to the iSHARE standards;
* The /delegation endpoint MUST be conforming to the iSHARE standards. For proper testing of this endpoint, users SHOULD provide two valid delegation requests: one that returns a “Permit” when requested, and one that returns a “Deny” when requested.

.. tip:: If you want to test your delegation endpoint, it is necessary to add ABC Trucking's EORI (EU.EORI.NL000000001) in some test-policy. This delegation will be tested against during conformance testing.

**Identity Providers**

* The /capabilities endpoint MUST be conforming to the iSHARE standards;
* The /authorize endpoint MUST be conforming to the iSHARE standards. For proper testing of this endpoint, users SHOULD provide error endpoint to which users will be redirected on invalid authorize requests;
* The /token endpoints (both M2M and H2M) MUST be conforming to the iSHARE standards;
* The /userinfo endpoint MUST be conforming to the iSHARE standards. For proper testing of this endpoint, users SHOULD provide two valid delegation requests: one that returns a “Permit” when requested, and one that returns a “Deny” when requested.

For proper testing of IdP endpoints, users SHOULD provide login endpoint towards which human authentication request will be sent. In addition users should also provide username and password HTTP request body parameter names that their API expects with existing human user credentials that is going to simulate the login.

.. note:: /token endpoint requirements for Identity Providers are different than for the other iSHARE participants.

Delegations testing
-------------------

An important aspect of testing an Authorization Registry is testing the /delegations endpoint. To be able to do this testing, it is necessary that the Conformance Test Tool can retrieve a '*dummy*' delegation. Users can enter two delegation masks in the Conformance Test Tool:

* **A Permit Mask**: This is a delegation mask that should resolve to "Permit" when used in a delegation request
* **A Deny Mask**: This is a delegation mask that should resolve to "Deny" when used in a delegation request

The Conformance Test Tool does multiple 'valid requests' to ensure that the implementation is correct. For example, one test case does a delegation request as if the request is done by the 'accessSubject' of the delegation mask. Another test case does a delegation request as if the request is done by a Service Provider from the 'environment' of the delegation mask. This requires the use of the 'previous_steps' field (see iSHARE Authorisation). For these delegation requests to work, it is important to know the following:

* The 'accessSubject' in the delegation mask needs to be 'EU.EORI.NL000000001'
* The 'environment' in the delegation mask needs to contain the Service Provider 'EU.EORI.NL000000003'
* A 'client_assertion' from 'EU.EORI.NL000000001' to 'EU.EORI.NL000000003' is included in 'previous_steps' in the delegation request when the request is done by 'EU.EORI.NL000000003'

Below you can see an example of the body of such a request.

.. code-block:: json

    {
      "delegationRequest": {
        "policyIssuer": "EU.EORI.NL000000005",
        "target": {
          "accessSubject": "EU.EORI.NL000000001"
        },
        "policySets": [
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
                      "EU.EORI.NL000000003"
                    ]
                  }
                },
                "rules": [
                  {
                    "effect": "Permit"
                  }
                ]
              }
            ]
          }
        ]
      },
      "previous_steps": [
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsIng1YyI6WyJNSUlFZ1RDQ0FtbWdBd0lCQWdJSU45VmlDRGkzQndzd0RRWUpLb1pJaHZjTkFRRUxCUUF3U0RFWk1CY0dBMVVFQXd3UWFWTklRVkpGVkdWemRFTkJYMVJNVXpFTk1Bc0dBMVVFQ3d3RVZHVnpkREVQTUEwR0ExVUVDZ3dHYVZOSVFWSkZNUXN3Q1FZRFZRUUdFd0pPVERBZUZ3MHhPVEF5TVRVeE1UUTJNVFZhRncweU1UQXlNVFF4TVRRMk1UVmFNRUl4RlRBVEJnTlZCQU1NREVGQ1F5QlVjblZqYTJsdVp6RWNNQm9HQTFVRUJSTVRSVlV1UlU5U1NTNU9UREF3TURBd01EQXdNVEVMTUFrR0ExVUVCaE1DVGt3d2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUMwTzRoVWhEK1ZvT0tWSVpTTk1OVGZ6YzBPMmtZaitaenBRRUFCWkd0UHR5MGtLUEplcDArbzV4c3RvdTFLK1V4dkhmeEVwSHhIR1RkdHFadWMyOExoVTRDZUNnb2VETURUK0NIUzNOb3NpRVNRTXdoL1paZVRjOS9lS0NvNTY5R0NuKzJYdFRpR1NwQlN3TVNXcU5IZ3BBWllLZEhyVC9rRU1JeVRLb2F1dWlLUThjVXA3b3c3bVp6LzlLK3FWM3M5TDAzMFc4SWF3TEpCSksvMmFwQXQ1amgxajQvbUY3ZjBxOHpoemhyQzh2MDFQTGxaZHVUempqQnJlN216K3lpL3ZsWXovZWFwMGVZVGpoeElhdHlWOUZGd2xtaTRGQzFDTmNNdExoOG5zaUpvZTVjQm0xM0xLYlFGdTNHWUg3Nm9lTFp2V3FiUGJwMTFteGxIYS9LZEFnTUJBQUdqZFRCek1Bd0dBMVVkRXdFQi93UUNNQUF3SHdZRFZSMGpCQmd3Rm9BVUZqem5JT25XbE84ZjVhTHh1UHkrNnQ4c040RXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUhBd0V3SFFZRFZSME9CQllFRkFQSCs4VXJZaVZMWGFLUFJHZmxrQStjdXNRN01BNEdBMVVkRHdFQi93UUVBd0lGb0RBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQWdFQVlsNXRXSDBZdFlTOUp5cXlsWkpXb21BNTVTaEtsbGFCUmN2cm82Q0h4bGxKV0hvMHFDOVpUTWN2Q3l3TXYxNFZKeVFkNmVGWnFjVnRPbHVHclJaQmtsSDlBYW5rb3ZwMkpMYXFjRDc5dDFDeXVYWm5JelRGbC9Ca01zRTZ3bEFKWFkvc2Fybm94ZWllalA0RS9FZi8wZXVJRnZCYUlDQ0YrS2QyV0pZYmJuMFd5MGRINDg0UUpiSHlNdFZmcjQyb0lwVU5WdUxTdTg0eUtZQWVtOUpCdVlUcDNZMEsyaGlFQVcvYk9LRHZ2SGV0VmY1ZnU2NnlmZWtEWDUzajNOS2lGSkNYUzJyS0lab0R1TUZ1eHBTeVZrUzJrYldrMSs1Sm95N3FPU05BTlJGUGxwSGNnekxRWnA4SHJndmhzbWhJdDFWVFZZa3l4Y2Q4cVhBbGh3cVZnT3E1TmdMeGtxdWw5aE5NR2lNN3NxK0g3M1EvRmk4aWY3Z1A4SVZBU3pRR3d1SGcyWjg3aWI2QTJ2b24wZlJKWnEzZkl1YkhveEk2M0FUd2ZjUks4NnkxNzJ4YkZFM1ZVMGR1TjF0STVaMFRDZzBHQUpZdEpwYm52ZXhJdDVsazVGSWs0VGh2UjBMOG1OTHkxRFVhMTFOK0VNeGtxYmZxbFR1ckI4WmczQ1kvUWFTS21YWTVDTVV3V2VFQlhSSGh5ZmtaUTVqUFBVSHJGYW95T1JYOHAxRXJZRGt0QjFLOW80am11RVZwQjMzY3ZnWUJFaUF5VjV6NDQyNkZ1VkNNYkhhRkRWN2lLVzllQmxYb3hlWm80WFg4K2pYeVNMNUdXOFh3TlJUSzVjNHZXMDJRM1ZKeVlWZTV1bWVzdHNLUStMUjhpQXpvVVNyZUsxOCtKa0FqQUpVPSJdfQ.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAxIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMSIsImp0aSI6ImI2YmViNzdmNDcxZTQ3ZDhhYjhmNmMwOTFmYzE4ZGZmIiwiaWF0IjoxNTU5MDUwNjY2LCJuYmYiOjE1NTkwNTA2NjYsImV4cCI6MTU1OTA1MDY5NiwiYXVkIjoiRVUuRU9SSS5OTDAwMDAwMDAwMyJ9.ctJyGBr9ytCWOdm0l6zrBWyiCzuI0h2fm0Hp0UFfisS99jfXvfUVUKauhxwrOYkrAif36xu3jhc0qJMhdmGZ5RXhw8DaHnurP1TH3j1fy8hKPKvwBCbz3PtlQWywWbiVodrtlmVkqK5HU-AMou1JzZIrC5AS5fxprGysfRuL3TcFKkG-VH3MipC7uyjLVutRIlOev_l_gZ9ALyQkBf0wp__uTj--COdukttCmvzCtFtde9JE_Jde6t5N4Wps8jYasWiJEiEFxEFfWvzJKihSpyl-PAHNf304HNMEgQlgw9CG9L-YywKT53vzNITjwYVD_Ihi2ONGmTjMF4bi_Z96yw"
      ]
    }

What is next?
-------------

After verifying compatibility:

In general you follow the steps listed below. Kindly refer to admission process at https://framework.ishare.eu/is/admission which is leading
* Apply for appropriate signing certificate with an authorized Certificate Authority which is in the trusted-list. Please note that application may take some time. For general non-binding guidance please refer to https://github.com/iSHAREScheme/eSEALsGuide and feel free to contribute your learnings to the same.
* Install certificate on your server
* Register certificate with iSHARE Satellite
* Sign Accession Agreement
* For Certified Roles: provide signed Assessment Framework for Certified Parties