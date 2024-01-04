Party
=====

Used to obtain information about iSHARE participant from the iSHARE iSHARE Satellite. Should be used to verify the status of an iSHARE participant.

.. warning:: This endpoint is obsolete and will be removed in the future. Please refer to :ref:`Parties Endpoint<refParties>` instead.

Request
-------

HTTP methods
~~~~~~~~~~~~

* GET

Headers
~~~~~~~

``Authorization``
    | **String**.
    | OAuth 2.0 authorization based on bearer token. MUST contain "Bearer " + access token value. How to retrieve the access token can be found at :ref:`Access Token Endpoint section<refM2MToken>`.

Parameters
~~~~~~~~~~

``party_id``
    | **String**. Path parameter.
    | Required parameter used to search by party's EORI.

``certificate_subject_name``
    | **String**. Query parameter. *Optional*.
    | subjectName as encoded in the X.509 certificate which corresponds with the party that is being requested from the iSHARE Satellite. Used by the iSHARE Satellite to match the certificate identifier. Subject name attributes may be in any order, but all of them must be included and separated by comma, if at least one subject attribute is missing - information won't be returned. Only returns info if combined with the valid ``eori`` associated to it.

``date_time``
    | **String**. Query parameter. *Optional*.
    | Date time for which the information is requested. If provided the result becomes final and therefore MUST be cacheable.

Example
~~~~~~~

::

    > Authorization: Bearer IIeDIrdnYo2ngwDQYJKoZIhvcNAQELBQAwSDEZMBcGA1UEAwwQaVNIQ

    GET /parties/EU.EORI.NL000000004?
        certificate_subject_name=C=NL, SERIALNUMBER=EU.EORI.NL000000004, CN=iSHARE Test Authorization Registry

(URL encoding removed, and line breaks added for readability)

Response
--------

Headers
~~~~~~~

``Content-Type``
    | **String**.
    | Defines response body content type. MUST be equal to *application/json*.

HTTP status codes
~~~~~~~~~~~~~~~~~

200 OK
    | When a valid request is sent an OK result should be returned.

401 Unauthorized
    | When ``Authorization`` header is either missing, invalid or token has already expired.

404 Not Found
    | When an access token is valid but requested party was not found.

Parameters
~~~~~~~~~~

``party_token``
    | **String (JWT)**.
    | A signed JWT which contains information about the party.

**Decoded party_token parameters:**

It contains :ref:`iSHARE compliant JWT claims<refJWTPayload>`. In addition to that it also contains the following parameters:

.. _refPartyInfo:

``party_info``
    | **Object**. Root level.
    | Contains information about the party.

    ``party_id``
        | **String**. Contained in ``party_info``.
        | iSHARE identifier of the party. Should be EORI number.

    ``party_name``
        | **String**. Contained in ``party_info``.
        | Name of the party.

    ``adherence``
        | **Object**. Contained in ``party_info``.
        | Object which contains status and validity timestamps of the party.

        ``status``
            | **String**. Contained in ``adherence``.
            | Status of the party. Available values are *Active*, *Pending*, *NotActive* and *Revoked*.

        ``start_date``
            | **Timestamp (ISO 8601)**. Contained in ``adherence``.
            | UTC timestamp which states since when adherence status has established.

        ``end_date``
            | **Timestamp (ISO 8601)**. Contained in ``adherence``.
            | UTC timestamp which states till when adherence status has established.

    ``certifications``
        | **Array of Objects**. Contained in ``data``.
        | Collection of certifications of the party.

        ``role``
            | **String**. Contained in the object of ``certifications``.
            | Role of acquired certification. Available values are *AuthorisationRegistry*, *IdentityProvider*, *IdentityBroker* or *SchemeOwner*.

        ``start_date``
            | **Timestamp (ISO 8601)**. Contained in the object of ``certifications``.
            | UTC timestamp which states since when certification is valid.

        ``end_date``
            | **Timestamp (ISO 8601)**. Contained in the object of ``certifications``.
            | UTC timestamp which states till when certification is valid.

        ``loa``
            | **Integer**. Contained in the object of ``certifications``.
            | Certificate's level of assurance. Available values are *1* (low), *2* (substantial) and *3* (high).

    ``capability_url``
        | **String**. Contained in ``party_info``.
        | :ref:`Capabilities endpoint<refCapabilitiesEndpoint>` of the party.

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/json

    {
      "party_token": "eyJ4NWMiOlsiTUlJRWlEQ0NBbkNnQXdJQkFnSUllRElyZG5ZbzJuZ3dEUVlKS29aSWh2Y05BUUVMQlFBd1NERVpNQmNHQTFVRUF3d1FhVk5JUVZKRlZHVnpkRU5CWDFSTVV6RU5NQXNHQTFVRUN3d0VWR1Z6ZERFUE1BMEdBMVVFQ2d3R2FWTklRVkpGTVFzd0NRWURWUVFHRXdKT1REQWVGdzB4T1RBeU1UVXhNVFEyTlRoYUZ3MHlNVEF5TVRReE1UUTJOVGhhTUVreEhEQWFCZ05WQkFNTUUybFRTRUZTUlNCVFkyaGxiV1VnVDNkdVpYSXhIREFhQmdOVkJBVVRFMFZWTGtWUFVra3VUa3d3TURBd01EQXdNREF4Q3pBSkJnTlZCQVlUQWs1TU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBMFJvb2hlUEwwMk52NEJaVEoza3A3bktzaHNtanJjcjhNQmFBaFFwWlpBc2dUQWxtUWlDVFBtM2M4cVlQcU4rVHVnZ0ZXQ05uKzlXNTRDNVVHcXNJd3RYVGszWWV4QXdaNG9qUlJ0bzhsMUhQRFZBUzZXdlc3NEFDTlpsRWdHd2pyQ0d5MitNNVFQN083d0IwVDZvRkJvZlJ3SFpHemdidFNiU1FodXF3VXhmMEdaSTh4QWwyL0dUSDI1VmZwOVQ3MUpFcG9aOWtzUDNDSWk1QkhrbGJUNUdLeEVPRmZkTU11cFg3bVduTlFiTHh1UXBBdEdDdW9yR2ZQRkU3RjVldkUxem9wd2NlQTVGc0UxTGFCUnF0K0VPcFBJbVNhalIwMmJjaEs5alM2bllFV3MvRlpHTHRKYWxsNUwzU25aTTZPaFd4TStsS0d6Rkt3NVRJWE45RE13SURBUUFCbzNVd2N6QU1CZ05WSFJNQkFmOEVBakFBTUI4R0ExVWRJd1FZTUJhQUZCWTg1eURwMXBUdkgrV2k4Ymo4dnVyZkxEZUJNQk1HQTFVZEpRUU1NQW9HQ0NzR0FRVUZCd01CTUIwR0ExVWREZ1FXQkJSZndpalQ3NWRJS1BsRkMvQ3RSRHFVS1g5VE5qQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFLNFBXVHEvZHF0Vm0rNFdDZDFLUUo0dGorbjRjY0lBWUxETXFZU0JKc042UTJjdE1SQy8rK3lNL293UEhCcmlUendXL2pvQXBOUGVaaDFJVFRnU3phMzhtM2h4b0RxMXV4NkhWR3lLNVFDUW9qRmRsZWM3dE9IbG1jYnV5VjRDRXlNWmJHK3lMbVZESTNxNTNWQVBnV3ZLSWkyUlVwc1BOdzJsbzZINjZ2SE5wNWZpcEIvdEU0Q0RsYS9UYU41MWxOM2xYT3c0bHRiWmJ6YmQ2TXhJbEVDUWZKSDVlUHJpcGFrSmhuaVZrWnZRVmthS0FlcFNYMGFEWUxPcFFRbmV0RFdab1ZKS0FzR0VMM0hMaWhxWXNEejcvQlQzRHdUMEtDNSs5OGdqR1p3dkx3ZXRKOTZLWFRBRTUwMmYzak95UDdERDZ1SytKS2d2UVp5dkk1L0V1cDBUdE5sUmZKeThhZDhweCszOG9JeEdBbGJzS29XbXowb2FNR0MrbFZHTlAyTTQ4TTdWa3RCVHB5bXF4Vnd0VGt2TVBqWldIS2xYdDJXMzNtTktHakpTOTVJNXZxT0tQV1NTc1dkSlJZSkNsbUVybWlkTlczMWxXQVZQcjFpU1M0SlhEdllQTENQNDRhNGVkMEdhV1pSdi9iK0QyK1FVZ09iOFN6bWpQdmYvMkdOdHFXUmR5WXRYWjl2eDAzNGkrWEYveWU4c2lOK1grd0ZIdFJ1bXRzd2Irc2NRZjRmVTZNaktCS1VzUERBUkFHakhqNXhIQkRqcTg0bmpHdVFjbDBoYlMzK1pTVjROcWtKSVVzMkxVdDlFdjFYN2FCNy85NUVYQWNnTlhkM0tQVm0zcDhORDc1QXFNMEZHUUVhUXlPd3FLY3FUQ2xKQ3VmR3NVWTRzN3JXUiJdLCJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAwIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMCIsImp0aSI6Ijc3ZTgxNzlmYmZlNjQ2OWViNjRjMDU0ZGEyNmE3N2MzIiwiaWF0IjoxNTg5MjgyMTEyLCJleHAiOjE1ODkyODIxNDIsImF1ZCI6IkVVLkVPUkkuTkwwMDAwMDAwMDEiLCJwYXJ0eV9pbmZvIjp7InBhcnR5X2lkIjoiRVUuRU9SSS5OTDAwMDAwMDAwNCIsInBhcnR5X25hbWUiOiJBc2tNZUFueXRoaW5nIEF1dGhvcml6YXRpb24gUmVnaXN0cnkiLCJhZGhlcmVuY2UiOnsic3RhdHVzIjoiQWN0aXZlIiwic3RhcnRfZGF0ZSI6IjIwMTgtMDQtMjZUMDA6MDA6MDAiLCJlbmRfZGF0ZSI6IjIwMjAtMDctMjVUMDA6MDA6MDAifSwiY2VydGlmaWNhdGlvbnMiOlt7InJvbGUiOiJBdXRob3Jpc2F0aW9uUmVnaXN0cnkiLCJzdGFydF9kYXRlIjoiMjAxOC0wMS0wNFQwMDowMDowMCIsImVuZF9kYXRlIjoiMjAyMC0wMi0wMlQwMDowMDowMCIsImxvYSI6M31dLCJjYXBhYmlsaXR5X3VybCI6Imh0dHBzOi8vYXIuaXNoYXJldGVzdC5uZXQvY2FwYWJpbGl0aWVzIn19.U2nIhL2600VX1uaMdJ_uUJky_Q8WSSRDKcbmeYrL_GGHifptwlB00uwj1uWmbUbd5KlYIYio-lPX1BwMzYmVXLC6ZydkI7kIsdQypiSEXGT6U2KIlTO2EyF3CU6EY6iBzuVtvyupbDVPkKzDVh8thE5cepCS_FAsZZvxYXfeWGjVoKRpHtAIGq8reTIgEE_9w-p6Toa970ERJ01Lcn3xpDPp-FNLobmMa_mM6Vn4m6WjvMxr77coO54GDJ6FM70egChiBHJSjUGqDaBUgebdAFh3AQ8TfYJntka9DiNVFiY5Y_HqecBmKW_DiokT40DiljXEhRy6YVLSHjxOKa81TQ"
    }

Decoded JWT Payload
^^^^^^^^^^^^^^^^^^^

.. code-block:: json

    {
      "iss": "EU.EORI.NL000000000",
      "sub": "EU.EORI.NL000000000",
      "jti": "77e8179fbfe6469eb64c054da26a77c3",
      "iat": 1589282112,
      "exp": 1589282142,
      "aud": "EU.EORI.NL000000001",
      "party_info": {
        "party_id": "EU.EORI.NL000000004",
        "party_name": "AskMeAnything Authorization Registry",
        "adherence": {
          "status": "Active",
          "start_date": "2018-04-26T00:00:00",
          "end_date": "2020-07-25T00:00:00"
        },
        "certifications": [
          {
            "role": "AuthorisationRegistry",
            "start_date": "2018-01-04T00:00:00",
            "end_date": "2020-02-02T00:00:00",
            "loa": 3
          }
        ],
        "capability_url": "https://ar.isharetest.net/capabilities"
      }
    }