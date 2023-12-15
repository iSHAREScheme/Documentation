.. _refParties:

Parties
=======

Used to obtain information about iSHARE participants from the iSHARE Satellite. Should be used to verify the status of an iSHARE participants. Returns 10 records per page. Furthermore offers limited search functionality through optional parameters, at least one optional parameter is required.

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

``active_only``
    | **Boolean**. *Optional*.
    | Optional parameter used to search by party's "Active" status.

``name``
    | **String**. *Optional*.
    | Optional parameter used to search by party's name. Can contain a single * as wildcard.

``eori``
    | **String**. *Optional*.
    | Optional parameter used to search by party's ID (EORI). Can contain a single * as wildcard.

``certified_only``
    | **Boolean**. *Optional*.
    | Search for parties that play one of the certified roles as defined in iSHARE role framework.

``date_time``
    | **String($date-time)**. *Optional*.
    | Search parties with specific adherence date.

``adherenceStatus``
    | **String**. *Optional*.
    | Search for parties with adherence status like "Active", "Revoked","Not Active", "Pending".

``adherenceStartdate``
    | **String($date-time)**. *Optional*.
    | Search parties with specific adherence start date.

``adherenceEnddate``
    | **String($date-time)**. *Optional*.
    | Search parties with specific adherence end date.

``registarSatelliteID``
    | **String**. *Optional*.
    | Search parties by their registrar satellite's ID (EORI) number.

``webSiteUrl``
    | **String**. *Optional*.
    | Search a party by their website URL.

``companyEmail``
    | **String**. *Optional*.
    | Search a party by their email ID.

``companyPhone``
    | **Integer($int32)**. *Optional*.
    | Search a party by their company phone number.

``publiclyPublishable``
    | **Boolean**. *Optional*.
    | Search parties whose general company contact information is allowed to be published.

``tags``
    | **String**. *Optional*.
    | Search parties who match any of the keywords that they have added in their participant information under tags. It is a free text field and can contain any value.

``framework``
    | **String**. *Optional*.
    | Search parties based on which framework they were onboarded with. Currently parties can only be registered with "iSHARE" framework.

``subjectName``
    | **String**. *Optional*.
    | Search parties based on the subject name of their PKI (x509) certificates. Usually to find a party who is requesting tokens.

``role``
    | **String**. *Optional*.
    | Search parties based on their roles as defined in iSHARE role framework. Possible roles are Service Consumer/Service Provider/Entitled Party/Authorisation             
    | Registry/Identity Provider/Identity Broker/iSHARE Satellite.

``loA``
    | **String**. *Optional*.
    | Search parties based on their level of assurance which is registered in the participant list. Possible values are Low/Substantial/High.

``compliancyVerified``
    | **Boolean**. *Optional*.
    | Search parties that have their compliance to framework verified or not..

``legalAdherence``
    | **Boolean**. *Optional*.
    | Search parties that have signed the appropriate legal agreements and that have been verified during or after onboarding. Parties adhering to legal agreements are legally 
    | obliged to adhere to terms of use of data.

``authorizationRegistryID``
    | **String**. *Optional*.
    | Search parties based on their authorisation registry provider. The ID (EORI) of the authorisation registry must be provided in search parameter and this must be listed as 
    | authorisation registry in the participant record.

``authorizationRegistryName``
    | **String**. *Optional*.
    | Search parties based on their authorisation registry provider. The name of the authorisation registry must be provided in search parameter and this must be listed as
    | authorisation registry in the participant record.

``dataSpaceID``
    | **String**. *Optional*.
    | Search parties based on data-spaces they participate in. The ID of the data-space must be provided.

``dataSpaceTitle``
    | **String**. *Optional*.
    | Search parties based on data-spaces they participate in. The name of the data-space must be provided.

``countriesOfOperation``
    | **String**. *Optional*.
    | Search parties by name of country they list as their country of operation.

``sectorIndustry``
    | **String**. *Optional*.
    | Search parties by name of sector they list as their sector/industry.

``page``
    | **Integer($int32)**. *Optional*.
    | The parties API by default uses pagination. Each page size is fixed at 10 parties per page. When search results into more then 10 parties, the page parameter must be
    | added for next pages.

``certificate_subject_name``
    | **String**. *Optional*.
    | Search parties based on the subject name of their PKI (x509) certificates. Usually to find a party who is requesting tokens.


.. note:: Even though all parameters are optional, at least one parameter should be provided. E.x. if you would like to retrieve all parties, you could use ``name=*`` or ``eori=*``.

Example
~~~~~~~

::

    > Authorization: Bearer IIeDIrdnYo2ngwDQYJKoZIhvcNAQELBQAwSDEZMBcGA1UEAwwQaVNIQ

    GET /parties?
        eori=EU.EORI.NL000000004&
        certificate_subject_name=C=NL, SERIALNUMBER=EU.EORI.NL000000004, CN=iSHARE Test Authorization Registry&
        active_only=true

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

400 Bad Request
    | When an access token is valid but query parameters are either invalid or none of them were provided.

401 Unauthorized
    | When ``Authorization`` header is either missing, invalid or token has already expired.

Parameters
~~~~~~~~~~

``parties_token``
    | **String (JWT)**.
    | A signed JWT which contains information about parties.

**Decoded parties_token parameters:**

It contains :ref:`iSHARE compliant JWT claims<refJWTPayload>`. In addition to that it also contains the following parameters:

``parties_info``
    | **Object**. Root level.
    | Contains results count and information about the parties.

    ``count``
        | **Integer**. Contained in ``parties_info``.
        | Total count of found parties. Since one request returns up to 10 parties, the value helps to understand if more than one page exists.

    ``data``
        | **Array of Objects**. Contained in ``parties_info``.
        | Collection of parties.

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
      "parties_token": "eyJ4NWMiOlsiTUlJRWlEQ0NBbkNnQXdJQkFnSUllRElyZG5ZbzJuZ3dEUVlKS29aSWh2Y05BUUVMQlFBd1NERVpNQmNHQTFVRUF3d1FhVk5JUVZKRlZHVnpkRU5CWDFSTVV6RU5NQXNHQTFVRUN3d0VWR1Z6ZERFUE1BMEdBMVVFQ2d3R2FWTklRVkpGTVFzd0NRWURWUVFHRXdKT1REQWVGdzB4T1RBeU1UVXhNVFEyTlRoYUZ3MHlNVEF5TVRReE1UUTJOVGhhTUVreEhEQWFCZ05WQkFNTUUybFRTRUZTUlNCVFkyaGxiV1VnVDNkdVpYSXhIREFhQmdOVkJBVVRFMFZWTGtWUFVra3VUa3d3TURBd01EQXdNREF4Q3pBSkJnTlZCQVlUQWs1TU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBMFJvb2hlUEwwMk52NEJaVEoza3A3bktzaHNtanJjcjhNQmFBaFFwWlpBc2dUQWxtUWlDVFBtM2M4cVlQcU4rVHVnZ0ZXQ05uKzlXNTRDNVVHcXNJd3RYVGszWWV4QXdaNG9qUlJ0bzhsMUhQRFZBUzZXdlc3NEFDTlpsRWdHd2pyQ0d5MitNNVFQN083d0IwVDZvRkJvZlJ3SFpHemdidFNiU1FodXF3VXhmMEdaSTh4QWwyL0dUSDI1VmZwOVQ3MUpFcG9aOWtzUDNDSWk1QkhrbGJUNUdLeEVPRmZkTU11cFg3bVduTlFiTHh1UXBBdEdDdW9yR2ZQRkU3RjVldkUxem9wd2NlQTVGc0UxTGFCUnF0K0VPcFBJbVNhalIwMmJjaEs5alM2bllFV3MvRlpHTHRKYWxsNUwzU25aTTZPaFd4TStsS0d6Rkt3NVRJWE45RE13SURBUUFCbzNVd2N6QU1CZ05WSFJNQkFmOEVBakFBTUI4R0ExVWRJd1FZTUJhQUZCWTg1eURwMXBUdkgrV2k4Ymo4dnVyZkxEZUJNQk1HQTFVZEpRUU1NQW9HQ0NzR0FRVUZCd01CTUIwR0ExVWREZ1FXQkJSZndpalQ3NWRJS1BsRkMvQ3RSRHFVS1g5VE5qQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFLNFBXVHEvZHF0Vm0rNFdDZDFLUUo0dGorbjRjY0lBWUxETXFZU0JKc042UTJjdE1SQy8rK3lNL293UEhCcmlUendXL2pvQXBOUGVaaDFJVFRnU3phMzhtM2h4b0RxMXV4NkhWR3lLNVFDUW9qRmRsZWM3dE9IbG1jYnV5VjRDRXlNWmJHK3lMbVZESTNxNTNWQVBnV3ZLSWkyUlVwc1BOdzJsbzZINjZ2SE5wNWZpcEIvdEU0Q0RsYS9UYU41MWxOM2xYT3c0bHRiWmJ6YmQ2TXhJbEVDUWZKSDVlUHJpcGFrSmhuaVZrWnZRVmthS0FlcFNYMGFEWUxPcFFRbmV0RFdab1ZKS0FzR0VMM0hMaWhxWXNEejcvQlQzRHdUMEtDNSs5OGdqR1p3dkx3ZXRKOTZLWFRBRTUwMmYzak95UDdERDZ1SytKS2d2UVp5dkk1L0V1cDBUdE5sUmZKeThhZDhweCszOG9JeEdBbGJzS29XbXowb2FNR0MrbFZHTlAyTTQ4TTdWa3RCVHB5bXF4Vnd0VGt2TVBqWldIS2xYdDJXMzNtTktHakpTOTVJNXZxT0tQV1NTc1dkSlJZSkNsbUVybWlkTlczMWxXQVZQcjFpU1M0SlhEdllQTENQNDRhNGVkMEdhV1pSdi9iK0QyK1FVZ09iOFN6bWpQdmYvMkdOdHFXUmR5WXRYWjl2eDAzNGkrWEYveWU4c2lOK1grd0ZIdFJ1bXRzd2Irc2NRZjRmVTZNaktCS1VzUERBUkFHakhqNXhIQkRqcTg0bmpHdVFjbDBoYlMzK1pTVjROcWtKSVVzMkxVdDlFdjFYN2FCNy85NUVYQWNnTlhkM0tQVm0zcDhORDc1QXFNMEZHUUVhUXlPd3FLY3FUQ2xKQ3VmR3NVWTRzN3JXUiIsIkxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdERRcE5TVWxHWTFSRFEwRXhiV2RCZDBsQ1FXZEpTVk5HVWtwM1IwRkJlV3BWZDBSUldVcExiMXBKYUhaalRrRlJSVXhDVVVGM1VrUkZWazFDVFVkQk1WVkZEUXBCZDNkTllWWk9TVkZXU2taV1IxWjZaRVZPUWsxUk1IZERkMWxFVmxGUlRFUkJVbFZhV0U0d1RWRTRkMFJSV1VSV1VWRkxSRUZhY0ZVd2FFSlZhMVY0RFFwRGVrRktRbWRPVmtKQldWUkJhelZOVFVJMFdFUlVSVFJOUkdONVRYcEZNVTFVVVhoTk1XOVlSRlJKZWsxRVkzbE5ha1V4VFZSUmVFMHhiM2RUUkVWYURRcE5RbU5IUVRGVlJVRjNkMUZoVms1SlVWWktSbFpIVm5wa1JVNUNXREZTVFZWNlJVNU5RWE5IUVRGVlJVTjNkMFZXUjFaNlpFUkZVRTFCTUVkQk1WVkZEUXBEWjNkSFlWWk9TVkZXU2taTlVYTjNRMUZaUkZaUlVVZEZkMHBQVkVSRFEwRnBTWGRFVVZsS1MyOWFTV2gyWTA1QlVVVkNRbEZCUkdkblNWQkJSRU5ERFFwQloyOURaMmRKUWtGUWRXVlNXRlZIVTFWbmRUZHhjRUZYU21wQlZrZzVlak14T1ZodWRVWnNaVlpsVHk5WWVHSktObFUwYVhoWVVrdDJWemgyUzFSV0RRb3haRkpqWmxGbFEzRllhemQxWVM5YWMzRk9jbkU0T1VWNE9UVmlNRzV4UjFWMk1VNXZTekpVT0hsRlFXdFJlbmw2V1Zwd1Z6UmpNbGxOUTJObk5XRnREUXBTZDBObVdXRm9TSFJLYlZoS1YzRlNSV1YyVFRWclNtOVBZV05MU0M5SFZXSnpaVzFVT1RSQ01FdFlVMDVSTmtsWFkwcDVhbkIxWVc5RWNHSTJWMlE1RFFvM1ZESnNkVkF4U1ZFMVoydG1kMVV6T0VOYVNrdFdhMkpaTTJWS2EweHNUM2QzZEVaelJsQlFNazAwWmpoMU5EYzVUMnROVlhJMUwyMHJlRzQzTTBwaERRcGFVMHBHVDBoMlNVNDJSRVp3UVd4ek1tRjROMEpvVlZOc1lrdE5NMWxGZFU1aU1FODBiMDgxZVc1RVJraDJiV3hzY0RaT2RUQkdNbGh2TUVKMU1GQXZEUXAxY1dJdk1EaFlkbFpYYm1VM2QyTjNWMXBTT1N0a056aHhLMDlzWmtNdmJTdDNRWGRCY1cxUlNFVnlPR2hLVG5aU05sTXZPRFJJUVdwVlpFMTVSMk5aRFFwVWRtOTJNSFJpTUZwM0wwRkxkMFJuT0ZCRE9WVkdVbGxpTUdOQ2NqQXJMMGRtWjIxS1VEVlJUVUZtVEhGcldHMWFkMWxSVTFveFJtRnRUbXhLYkcxNERRb3djMWxhVVZOaGRXUkhNQ3RZYTJNNU9URXJXbmN2ZURoMVYxcHBPWEZSV21WQ1QyUjNia2t5ZUdZdlNFcFlTRXB6WVZwbVJIWlVjRFZwT0dsV1VEYzFEUW94Y21ocGJuZE1hVEprV201dFUzTlJPVFpuZG5SVVVVSnZORW8xUVhaR0szTTVTV3dyVkhWclpVeDBiRXRCUW1GdlRYZDZPSGRaUWtOdVprdDJWWFJyRFFwd04wcFZOV2xxYWxsR1lYRlJjMFpTTTFKd1QwaFlZMGd2YzNCYVZGbElkVk56TVU5d1NGWmljakF2WTBaMFYxcHdkalIwVTFGcmJGQnhRMnBrWkZOQkRRcFRTRGxyTTA5Q1FXaDRaVzU1V0V4cmJqbFZPVUZCU1RNMGNGcGlSbFlyYld0elIwZHlUamQxYTJzMGIySlRkRWszZWk4MVFXZE5Ra0ZCUjJwWmVrSm9EUXBOUVRoSFFURlZaRVYzUlVJdmQxRkdUVUZOUWtGbU9IZElkMWxFVmxJd2FrSkNaM2RHYjBGVmNtRXpTM05VYmxWV2JsazRTMWhuYkRCU2FXbFJRblJ2RFFwTFJYZDNTRkZaUkZaU01FOUNRbGxGUmtKWk9EVjVSSEF4Y0ZSMlNDdFhhVGhpYWpoMmRYSm1URVJsUWsxQk5FZEJNVlZrUkhkRlFpOTNVVVZCZDBsQ0RRcG9ha0ZPUW1kcmNXaHJhVWM1ZHpCQ1FWRnpSa0ZCVDBOQlowVkJaVWxLZHpGdWJtOVBjbk5oYlhWbFZ6UmpXbEJNZW5KdWRVaFRSWFoyTVZORlRERmlEUXBtUWpaR056TmhibTE0WW5FNUswOVpWelp4YjJwb2VIWnZja2hVUm5wdlVYbHVjMUJ0WW5Odk4zUTBZak5JUVhSWFlVOXNjRE5FUzFwVlZIQjZUMnhNRFFwdVVUbG5jMFJFWmtSV1UwcHpTalZxZUdkc1JFWmFiVEJCTURkTVpETkRlRnBvYm5wWFpqbEJNRkZuVG5GT05XaERZMDl6Y213MGRVUk5kbHA2SzAwNURRcHJUQzlwYTNORGVEUllNSE52TWs5VGJURlJZV3R5WVVGU00zVnRVR015YjI5QllXTlFjMEZXUTJ4c1pXdFlSa281UkVacVNqVlZkaXR5WnpoYVMwaElEUXBNUjNKUU1UbHZMMEZ6V0VwWmNFdFFMM1IwYXpWMFFuVkJORXBDTWpCaFUyaGlZME0xTXpseVFTdFJZeXRyUkVoNVVtNU1NR0ZLZVZKWlpVSm5XVEZwRFFwQmRIVjZXSHBOVDJzMU0xaFdLMkZLYjJkRWNETm5SamN6Y3pGak1WbDVTVkpJZERkdlpsRkhMekJhYkhkakx6UXhRM2hQUkN0c2VYcEhNelJTYTJkSkRRcFZUelpWWm1wcFIwTkdVRzFhVVRKSWEzQkxlWEZNYVdaeVlWSmtjWEpJV0U5b2IxWmtOMGhwWkZsSmFXaHVXa3RFYTB4cE1XTm1aVzh5YlhvNGRGZHBEUXBWZWtFclpGQmphR0ZKUld4d1VVcFFWR3BUWWt4cVJqSkpNVGxSZVVJNFpuVlFZWHBRWms1SmFraHlXR0ZMYkdGVE0yeDFTMk5HYVhGUFdXZGpkMWRtRFFwa1dtMUVlbmhKVlRaUVdUSmllbmd2VTBSTmIxVXlOSEpCVmxOMVIwRlpRa2xCYkhkbU1uQjRiWFJNWTJKTlFUWmlXWEkwZEhKdFVXWmlTbkpOT0dZNERRcEtXbWRIVVc5SmRISndlbkpMYWtKS01tZEdVblFyTURZMVRrMVVUbXRDTlhKM09GaHlOVFpxTldScWEzRkNNQzl4U0VsalJqSlVhVmt2YXk4NE1WSnREUXBVUTFsNGNsWkllazB4WTNwb1dFaFlXWHAyYm1ReVNtd3hkMHBZZVdGalYydzNSbWxRWVdkbmR6QlpVV2xrVjBoSFRXUkpkRVYxUkM4NFUxaHBRMWhzRFFveFQwbDJkbWxqUFEwS0xTMHRMUzFGVGtRZ1EwVlNWRWxHU1VOQlZFVXRMUzB0TFEwSyIsIkxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdERRcE5TVWxHWWxSRFEwRXhWMmRCZDBsQ1FXZEpTVWhxYW1aVWRWTnFSbXBOZDBSUldVcExiMXBKYUhaalRrRlJSVXhDVVVGM1VrUkZWazFDVFVkQk1WVkZEUXBCZDNkTllWWk9TVkZXU2taV1IxWjZaRVZPUWsxUk1IZERkMWxFVmxGUlRFUkJVbFZhV0U0d1RWRTRkMFJSV1VSV1VWRkxSRUZhY0ZVd2FFSlZhMVY0RFFwRGVrRktRbWRPVmtKQldWUkJhelZOVFVJMFdFUlVSVFJOUkdONVRYcEZNVTFFVlhoTk1XOVlSRlJKTkUxRVkzbE5SRVV4VFVSVmVFMHhiM2RTUkVWV0RRcE5RazFIUVRGVlJVRjNkMDFoVms1SlVWWktSbFpIVm5wa1JVNUNUVkV3ZDBOM1dVUldVVkZNUkVGU1ZWcFlUakJOVVRoM1JGRlpSRlpSVVV0RVFWcHdEUXBWTUdoQ1ZXdFZlRU42UVVwQ1owNVdRa0ZaVkVGck5VMU5TVWxEU1dwQlRrSm5hM0ZvYTJsSE9YY3dRa0ZSUlVaQlFVOURRV2M0UVUxSlNVTkRaMHRERFFwQlowVkJORWhKVVRKbFIxaFRVREJpY1dkUGN6WkpZbko0Vkhjdk1IVTJXSGxTYVRWSUwxb3JhamhvVUhwR1pWTXZiamRWWTBSekt6UTRSMWxUWjBWT0RRb3hZMGxFUWtGSFYycHVkMDVOTm5VMFVuQlJhVWM0ZUd3M1dYUnFWM2x0ZDB0dE5FaFlkRXhCVVhGME56SmhjbGt6TjFCVFJqTXdXR2syVmxCQ1lXNTBEUXBRVkdSaFlTczVla05WT0VONVJtNUZXakptUzFSck1WTjFaek0yWnpaR05rOXFaR2REUTBkcmFtUndjRXRXZVU1SmJEVlBWeXRyYWtaeE1rRTVSM1owRFFwQ1VrZEZkMUl5WlhSdmRFdDBjMGxJU1M5bk5HTllUMFphYW5SRFEzUlFiMFZ0YWxFMk5tWlRkMkUzUVdwdmJIQkNZakpRWTNOelExWndZalZqTm5OQkRRcG1jREl3U2s1dU9EUnJSRkZGYjBocVpXOTVUa0Z4WTNSQ1JVbHpVbHBHTkd0d1ZHNDBXV2hUV0hFd1ZFZ3ZhMUowUlVWbVRrVnRla3hGVDFOaFJGZFFEUXA1VERoeFNrcHdlREZoVUVGNVpUQm1hMGRtU21rMU1XTkhVbkpHZUdZM2FtWk9PVGxVYW1SbU0zbDRkM1JVTDNsUmNYVlhUSEEyVmt4a2NXcEtUR3M1RFFwaWRFZHJLMEpwVXpscFZuUjNOREZGWXpKNWMxZ3ZNMmN3ZUdWV1ZrWkhkSGxEZDBGRFYzQjVTWGdyVVcwNE1FdHFWbGhyV1VSNGFFZHBURkZxVVVsNkRRcFdiMnhRUlZaVlJFRmFibmNyVEVOdFp6TlBXVGxKZVRCUVdGUldNSGd6UTB0SVRTdERNM1ZyV2xkclV6RmtNME5UWjBSV2JERXJZM0JJU2xRMGJUWm1EUXBMYm01alR6YzNlVlpQTUhseVZ6VXlNVGhWUjJGWlFVeFBhRGhRU0c5M016WmxPV05DTW1Nd1lsUXlaREZEU0ZKbGExTnNOQ3RDZUN0NFVVMUhkM05RRFFwNWRtVkhaM0JyU0dsa1duUlpVa1JRTkVVdlNIaE9TM2tyZDJaQ2VWRmxVM1UwV1dOVll6aEZTSGg1T1hGNmVHRmxNamhSWmxwdU4zTTBOMVl2VUdwQkRRcHJNR1JNV25sUlJHOXVSVGxSTVRCUGEwMVdNVFZFY0RsUVYwZGxRMUZLY21rMVNtUlBibklyYVVRNFJHUkljME5CZDBWQlFXRk9hazFIUlhkRWQxbEVEUXBXVWpCVVFWRklMMEpCVlhkQmQwVkNMM3BCWmtKblRsWklVMDFGUjBSQlYyZENVM1J5WTNGNFQyUlNWMlJxZDNCbFExaFNSMHRLUVVjeVoyOVVSRUZrRFFwQ1owNVdTRkUwUlVablVWVnlZVE5MYzFSdVZWWnVXVGhMV0dkc01GSnBhVkZDZEc5TFJYZDNSR2RaUkZaU01GQkJVVWd2UWtGUlJFRm5SMGROUVRCSERRcERVM0ZIVTBsaU0wUlJSVUpEZDFWQlFUUkpRMEZSUWtOSFdVNXNMekZJUmxkV2FFUnZVRzFyY0ZaeGJUTXdjbmx4Wmpaa1YzZ3hjbmhVVnpGc2F6bGhEUXBXVlU5c1VqbEpVa2hRY0RGNkwwWXZOR1ppTm0xSldFWnFSbGwzTld4Vk1tWmhTRlk1YjNBMGNrNTFSM0ZTVWxOTWFWRlFWblpQV0hoRWJIaHhRVFpFRFFwdGNYcHBVa1YyZEhSSE1IVk1XaTlHVDNsalMxazFNM0JYUmtONlJ6SnJaWEUyVDBsa09VcFRjRVp0VVVSUGFVWTNWMU4xYVdaUVRIVjNRVVJyVlhjckRRcHZXbGxIWjFkdFluZFJUekJzV0hSM04xaFBibmt6TjI1TVdtdFpiRGc1WWxKb1NXY3ZOMlppSzFodVlqZzVNVFJUVFhZd2EwZHNhekZyUTJWNVREWkdEUXBZWkZoU1ZHRmhkRFZqT1Zoc1NuSTVlWHBQVlVsRWJqVTBZbGt4UWt0VU5sbDBhWGxLWm5aRFRtRjJMMFppTWpSMk5XVnhNbG81YlVKa1dqY3dRMk01RFFvMVoxQnFjWEY0VFZwVlowcHZOVGRaZG1oTVpsaEVkM2hpVjFwWFdVTXJWMk5TT0c1SWExa3JkRnBDYkVscGFESkRXRWh6VDJGeU5XOUlObVJ5VFdSMERRcE5TVnA2TTFWYVNpOURlRVpITVhVeU0xVjZNV3BDWm0wdlJXZG5aRXRvVDFadVZEWmxaSEoxVm05MFpWZFhRMFJDT1Voa2FIaDZPRkpCVmxsdU5XUnhEUXBWYW10cVVuRTBWemxSUVdaS2RYTnlVRnBIUW01a1ZEZDVUbUZaTDBaSVdVdEpjU3QxVkdGeVYybGlhbVI0ZEdSWlEyeGhWSGRQZUdzMVNYRkxUa1k1RFFwbFEwdGlVRzE0Y3pGdGJGcHlVMHhxVFZGR1dUTlZPVkpyZG5wSkt6TkpiRUZHYTJOMFZXVmhZbkJyYlZoNGJuVlhWMU5XTWtaS1R6bGFjazlPVFZkMURRcDBkeXMxTmpkUVN6Vm5lazB3Um5GUmRtSTNjME40V25WUlJHdzFRM1EyV2xkc2RITXlXVGN5ZERad1VHcFNTVEUzSzFNNEt5dGhNblpSWkhoQ1kwNVJEUW93ZUVZeWRHcDJlbFIyYVZvelF6VkZjVWxsWVhwWFpHZEpXbXR4WmxkYWExTTRkaXN3VFVGMlRscFpLMkppZUN0MlUzZE1UMjlJVVZkeVppOVBRMHczRFFwQlVUMDlEUW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHREUW89Il0sImFsZyI6IlJTMjU2IiwidHlwIjoiSldUIn0.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAwIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMCIsImp0aSI6IjA4Njg5MDRkOGVkOTRjMDFhMGE0ZDZkZDVjNjVjZTllIiwiaWF0IjoxNTkxOTY1OTA1LCJleHAiOjE1OTE5NjU5MzUsImF1ZCI6IkVVLkVPUkkuTkwwMDAwMDAwMDEiLCJwYXJ0aWVzX2luZm8iOnsiY291bnQiOjEsImRhdGEiOlt7InBhcnR5X2lkIjoiRVUuRU9SSS5OTDAwMDAwMDAwNCIsInBhcnR5X25hbWUiOiJBc2tNZUFueXRoaW5nIEF1dGhvcml6YXRpb24gUmVnaXN0cnkiLCJhZGhlcmVuY2UiOnsic3RhdHVzIjoiQWN0aXZlIiwic3RhcnRfZGF0ZSI6IjIwMTgtMDQtMjZUMTQ6NTk6MTRaIiwiZW5kX2RhdGUiOiIyMDIwLTA3LTI1VDE0OjU5OjE0WiJ9LCJjZXJ0aWZpY2F0aW9ucyI6W3sicm9sZSI6IkF1dGhvcmlzYXRpb25SZWdpc3RyeSIsInN0YXJ0X2RhdGUiOiIyMDE4LTAxLTA0VDAwOjAwOjAwWiIsImVuZF9kYXRlIjoiMjAyMC0wMi0wMlQwMDowMDowMFoiLCJsb2EiOjN9XX1dfX0.rwNcyK_4h2eA8ZjYC5NBLWTegwQH_e3CJTDrjX3s9dcykekJ5ri7iGf4GPuEJpbXDUI2FgV00IuqW2UkznQsDsw0HDejJLZ9PJGxQXlSC4-r3Lbx9SSuVAk4uTClOdnAYgtpwWyjXLTYHbWb1fj9-xqjZ851CmRtp2rOWOSRXWYLmjG7s0fwTFNyy4C03trEmnelk3jyQkZCNRhFeflIywNLSBPPo5MqKEz3Fe3AxpKybuPRMVotWaCQvROUws99m7dUIXSpD8mUYomtOalDJ_2LJffHfLXqEoWkQTKmru_hboNJhrveg7PfziXrxruGO07Mn4ZqwH-RxOMTxY_aaQ"
    }

Decoded JWT Payload
^^^^^^^^^^^^^^^^^^^

::

 {    
  "parties_token": {
    "iss": "EU.EORI.NL123456789",
    "sub": "EU.EORI.NL123456789",
    "aud": "EU.EORI.NL123456789",
    "jti": "378a47c4-2822-4ca5-a49a-7e5a1cc7ea59",
    "exp": 1504684475,
    "iat": 1504683475,
    "parties_info": {
      "count": 0,
      "data": [
        {
          "party_id": "EU.EORI.US000000005",
          "party_name": "Example Corporation",
          "capability_url": "https://www.example.com/capabilities",
          "registrar_id": "EU.EORI.NL123456789",
          "adherence": {
            "status": "Active",
            "start_date": "2023-01-31T00:00:00.000Z",
            "end_date": "2024-02-01T00:00:00.000Z"
          },
          "additional_info": {
            "description": "Example is a corporation providing example services to its customers in example regions",
            "logo": "https://www.example.com/logo.png",
            "website": "https://www.example.com/",
            "company_phone": "string",
            "company_email": "John.doe@example.com",
            "publicly_publishable": false,
            "countries_operation": [],
            "sector_industry": [],
            "tags": "mobility transport_operator"
          },
          "agreements": [
            {
              "type": "TermsOfUse",
              "title": "TOU",
              "status": "Accepted",
              "sign_date": "2023-01-31T00:00:00.000Z",
              "expiry_date": "2024-01-31T00:00:00.000Z",
              "hash_file": "614331b0003219f2d2d123b0cd6105fb",
              "framework": "iSHARE",
              "dataspace_id": "",
              "dataspace_title": "",
              "complaiancy_verified": "yes"
            },
            {
              "type": "AccessionAgreement",
              "title": "AA",
              "status": "Accepted",
              "sign_date": "2023-01-31T00:00:00.000Z",
              "expiry_date": "2024-01-31T00:00:00.000Z",
              "hash_file": "f50a036402b3b243910ce572930be9f5",
              "framework": "iSHARE",
              "dataspace_id": "",
              "dataspace_title": "",
              "complaiancy_verified": "yes"
            }
          ],
          "certificates": [
            {
              "subject_name": "SERIALNUMBER=EU.EORI.US000000005,CN=CFMInternational,O=CFM International,C=US",
              "certificate_type": "Pkio",
              "enabled_from": "2023-01-31T00:00:00.000Z",
              "x5c": "",
              "x5t#s256": ""
            }
          ],
          "spor": {
            "signed_request": "f1aec63b5b6f545718dc1c86efda3a9e8d8c74c4c2af42b39d9e8d41f3fc2b4e"
          },
          "roles": [
            {
              "role": "ServiceConsumer",
              "start_date": "2023-01-31T00:00:00.000Z",
              "end_date": "2024-01-31T00:00:00.000Z",
              "loa": "High",
              "compliancy_verified": true,
              "legal_adherence": true
            }
          ],
          "auth_registries": [
            {
              "name": "iSHARE Test Authorization Registry",
              "id": "EU.EORI.NL000000004",
              "url": "http://ar.isharetest.net/",
              "dataspace_id": "ContaktDS1",
              "dataspace_name": "ContaktDS1"
            }
          ]
        }
      ]
    }
  }
 }
