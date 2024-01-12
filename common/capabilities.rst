.. _refCapabilitiesEndpoint:

Capabilities
============

The ``/capabilities`` endpoint is required for every participant that provides services:

* iSHARE Satellite
* Authorisation Registry
* Service Provider
* Identity Provider

The endpoint returns iSHARE capabilities of the iSHARE party. The server response is an iSHARE signed JSON Web Token.

Depening on whether or not an Access Token is provided to the capabilities endpoint, the endpoint must return public or public and restricted endpoints. in detail:

* If an access token IS NOT provided
    * Return public endpoints, including the Access Token endpoint
* If an access token IS provided
    * Return public endpoints, including the Access Token endpoint
    * Return restricted endpoints

Any endpoints that are not intended to be part of the capabilities to be used by iSHARE roles (out of scope of iSHARE) must not be included in the capabilities endpoint return.

Request
-------

HTTP methods
~~~~~~~~~~~~

* GET

Headers
~~~~~~~

``Authorization``
    | **String**. *Optional*.
    | OAuth 2.0 authorization based on bearer token. MUST contain "Bearer " + access token value. Must be provided if restricted endpoints are needed. How to retrieve the access token can be found at :ref:`Access Token Endpoint section<refM2MToken>`.

Example
~~~~~~~

::

    > Authorization: Bearer IIeDIrdnYo2ngwDQYJKoZIhvcNAQELBQAwSDEZMBcGA1UEAwwQaVNIQ

    GET /capabilities

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
    | When an access token is not provided or correct access token is provided an OK result should be returned.

400 Bad Request
    | When ``Authorization`` header is provided but token format is invalid (e.x. not Bearer).

401 Unauthorized
    | When ``Authorization`` header is provided, an access token is valid, but has already expired.

Parameters
~~~~~~~~~~

``capabilities_token``
    | **String (JWT)**.
    | A signed JWT which contains capabilities for requesting party.

**Decoded capabilities_token parameters:**

It contains :ref:`iSHARE compliant JWT claims<refJWTPayload>`, however if an access token is not provided, then ``aud`` claim should be ommitted while signing JWT. In addition to that it also contains the following parameters:

``capabilities_info``
    | **Object**. Root level.
    | Contains information about capabilities.

    ``party_id``
        | **String**. Contained in ``capabilities_info``.
        | Party ID, also known as EORI number of the party which provides the capabilities info.

    ``ishare_roles``
        | **Array of Objects**. Contained in ``capabilities_info``.
        | Contains array of ``role`` objects that provide the information about the roles of the party in iSHARE.

        ``role``
            | **String**. Contained in ``ishare_roles``.
            | Should be on the following values: *ServiceConsumer*, *ServiceProvider*, *EntitledParty*, *AuthorisationRegistry*, *IdentityProvider*, *IdentityBroker*, *iShareSatellite*.

    ``supported_versions``
        | **Array of Objects**. Contained in ``capabilities_info``.
        | Contains information about supported version endpoints for each version.

        ``version``
            | **String**. Contained in ``supported_versions``.
            | Version of the system which is under support.

        ``supported_features``
            | **Array of Objects**. Contained in ``supported_versions``.
            | Contins a list of supported features for different access levels.

            ``public``
                | **Array of Objects**. Contained in ``supported_features``.
                | Contains supported public features.

                ``id``
                    | **String**. Contained in the object of ``public``.
                    | Unique identifier of the feature.

                ``feature``
                    | **String**. Contained in the object of ``public``.
                    | Friendly name of the feature.

                ``description``
                    | **String**. Contained in the object of ``public``.
                    | Short description about the feature.

                ``url``
                    | **String**. Contained in the object of ``public``.
                    | URL to the feature.

                ``token_endpoint``
                    | **String**. Contained in the object of ``public``. *Optional*.
                    | URL where access token for the feature could be retrieved. This is optional because if feature is *access token*, it is not needed to mention it twice.

            ``restricted``
                | **Array of Objects**. Contained in ``supported_features``. *Optional*.
                | Contains supported restricted features. The structure and parameters are exactly the same as defined in ``public`` parameter above. It should only be shown to the parties which provided a valid access token. If an access token was not provided or restricted endpoints does not exist, this value can be not returned, empty or null.

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/json

    {
      "capabilities_token": "eyJ4NWMiOlsiTUlJRWdUQ0NBbW1nQXdJQkFnSUlTOTBLKzFROUhPa3dEUVlKS29aSWh2Y05BUUVMQlFBd1NERVpNQmNHQTFVRUF3d1FhVk5JUVZKRlZHVnpkRU5CWDFSTVV6RU5NQXNHQTFVRUN3d0VWR1Z6ZERFUE1BMEdBMVVFQ2d3R2FWTklRVkpGTVFzd0NRWURWUVFHRXdKT1REQWVGdzB4T1RBeU1UVXhNVFEzTVRWYUZ3MHlNVEF5TVRReE1UUTNNVFZhTUVJeEZUQVRCZ05WQkFNTURGZGhjbVZvYjNWelpTQXhNekVjTUJvR0ExVUVCUk1UUlZVdVJVOVNTUzVPVERBd01EQXdNREF3TXpFTE1Ba0dBMVVFQmhNQ1Rrd3dnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDd2FEQXpFSjI4REtURmRQUHU5b0o0SnQ2NHBLeEFIc1AzRkhMeVk1N1VpcGRCOW1vMTU3eGY5MXo1dlpNY05NdXFVdWF1OE9IVHpseWtQQTl0Q0VPb2NFMERZd1I3RzBFM1F6bnE5VjhVRy9oY242eGVxY1J2NTV3RS9sZDdFUVV1SnhZaHJ1VVVwNnc4S3lYQnZWdHRkVzhFMnlxa3lDVmFCRTUwRHNzaFlxazdnaVFDSExtVlhSSm44dDZDdW52dGlIdHVuTzBaM1hlM0U1TVJma0NqTm5jajdPTVRNQ1h2OHVDTlNkOE4ydGV1YmhUM2dBQnpXMlBqdTJFeU54SmV6eWRTSXU5eTNYa3VnZUNKSUdIRlk4TEtSZXU5YUV6dDhhTC9NeTdaOENKaklWRzFjRDBmREZ0NEpaeHVZd1c4RC9uamw0Q21PTERhR2VwZ0dHd2ZBZ01CQUFHamRUQnpNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVGanpuSU9uV2xPOGY1YUx4dVB5KzZ0OHNONEV3RXdZRFZSMGxCQXd3Q2dZSUt3WUJCUVVIQXdFd0hRWURWUjBPQkJZRUZHYm92VjdGTE01MkZjYStZRTJkRXFvK0tveHFNQTRHQTFVZER3RUIvd1FFQXdJRm9EQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FnRUFKdHZFMmlBYXB1Rzh5cm9WeWVpNEd2dGpmTStJT3RoczFWd2ozWjR0TnRXalc4VTFZcXFnd2ZBSThnUHVDekk2SEdNRDBycnZ6SVM2dGc0cGVUekRFZFk2VmZDNGx0bWNTNWNwaFlZcXM2WDB3aWZUcDRWVmJQdCs2R3hwTWU5b01CVGNBR1JIVGF4VzJmYVBzclFtZkRuaGNoSEZsU2FqaHF4RDVnUi9GWXZYZUFHc29QMEJCcW1SUkRiUnR5ZFB4Qnd1WVFyVTdUSmQraXJQdmhDVm9BMENPQ0FZM2loU3N5UHBuK0xDYnJsQ2JkNVNGRHBIOWFXdHQ2MmlqQ3M4TWRETk1QMmw1bGJ3clFCN3YxYnNGelkxU3hTQ0QxRTh5bVhrQlFSaENCY2cwbWszRXNTVmpkL0dCWG52Q3RCNzdlVUY4MGdMMUR4VzJwT2huTU5DdDMwcTFnemQvajJ0bWNLb0tvR3puUFFDL3NkNWs0c29tLytIdE9ZUWJTbVliQW5LcmFJVWdqUmQzYTN1UzFYQkZHWjMvem9JTXNuMXFOdnI1cENPRkJWcXlLVEp0S1ZjRzcvZi9ncXgxdGplOGVzV0c4bjZReUlPWjBXbWEzVnBaVnFEZGFYRHIrSi9rQ2FZcC9IbUZ2RjhDVkNDQlJSV082ajR6UXh0dXJxL1ZhZUxMOCtJYjlTb1FvRld5UnBMbkZpeXU3em81cUxBNlg1UThTY3owL0pONElOcW5EaFBMYWRrL0p3ZEF0RC80eFBZVlZUYUFYc2hlQmtlKy85QS9nZ0tJakpoazlhUEV2OE1KcnhDa0F1Zm1iVS9pVFVYYXVpUGhjaGM4RmEwZ05IV0RrOW1nMDcyek5HRW1hUlNQSjJQZm52dzNuTXhDanpleDVOdzB0ND0iLCJMUzB0TFMxQ1JVZEpUaUJEUlZKVVNVWkpRMEZVUlMwdExTMHREUXBOU1VsR1kxUkRRMEV4YldkQmQwbENRV2RKU1ZOR1VrcDNSMEZCZVdwVmQwUlJXVXBMYjFwSmFIWmpUa0ZSUlV4Q1VVRjNVa1JGVmsxQ1RVZEJNVlZGRFFwQmQzZE5ZVlpPU1ZGV1NrWldSMVo2WkVWT1FrMVJNSGREZDFsRVZsRlJURVJCVWxWYVdFNHdUVkU0ZDBSUldVUldVVkZMUkVGYWNGVXdhRUpWYTFWNERRcERla0ZLUW1kT1ZrSkJXVlJCYXpWTlRVSTBXRVJVUlRSTlJHTjVUWHBGTVUxVVVYaE5NVzlZUkZSSmVrMUVZM2xOYWtVeFRWUlJlRTB4YjNkVFJFVmFEUXBOUW1OSFFURlZSVUYzZDFGaFZrNUpVVlpLUmxaSFZucGtSVTVDV0RGU1RWVjZSVTVOUVhOSFFURlZSVU4zZDBWV1IxWjZaRVJGVUUxQk1FZEJNVlZGRFFwRFozZEhZVlpPU1ZGV1NrWk5VWE4zUTFGWlJGWlJVVWRGZDBwUFZFUkRRMEZwU1hkRVVWbEtTMjlhU1doMlkwNUJVVVZDUWxGQlJHZG5TVkJCUkVORERRcEJaMjlEWjJkSlFrRlFkV1ZTV0ZWSFUxVm5kVGR4Y0VGWFNtcEJWa2c1ZWpNeE9WaHVkVVpzWlZabFR5OVllR0pLTmxVMGFYaFlVa3QyVnpoMlMxUldEUW94WkZKalpsRmxRM0ZZYXpkMVlTOWFjM0ZPY25FNE9VVjRPVFZpTUc1eFIxVjJNVTV2U3pKVU9IbEZRV3RSZW5sNldWcHdWelJqTWxsTlEyTm5OV0Z0RFFwU2QwTm1XV0ZvU0hSS2JWaEtWM0ZTUldWMlRUVnJTbTlQWVdOTFNDOUhWV0p6WlcxVU9UUkNNRXRZVTA1Uk5rbFhZMHA1YW5CMVlXOUVjR0kyVjJRNURRbzNWREpzZFZBeFNWRTFaMnRtZDFVek9FTmFTa3RXYTJKWk0yVkthMHhzVDNkM2RFWnpSbEJRTWswMFpqaDFORGM1VDJ0TlZYSTFMMjByZUc0M00wcGhEUXBhVTBwR1QwaDJTVTQyUkVad1FXeHpNbUY0TjBKb1ZWTnNZa3ROTTFsRmRVNWlNRTgwYjA4MWVXNUVSa2gyYld4c2NEWk9kVEJHTWxodk1FSjFNRkF2RFFwMWNXSXZNRGhZZGxaWGJtVTNkMk4zVjFwU09TdGtOemh4SzA5c1prTXZiU3QzUVhkQmNXMVJTRVZ5T0doS1RuWlNObE12T0RSSVFXcFZaRTE1UjJOWkRRcFVkbTkyTUhSaU1GcDNMMEZMZDBSbk9GQkRPVlZHVWxsaU1HTkNjakFyTDBkbVoyMUtVRFZSVFVGbVRIRnJXRzFhZDFsUlUxb3hSbUZ0VG14S2JHMTREUW93YzFsYVVWTmhkV1JITUN0WWEyTTVPVEVyV25jdmVEaDFWMXBwT1hGUldtVkNUMlIzYmtreWVHWXZTRXBZU0VwellWcG1SSFpVY0RWcE9HbFdVRGMxRFFveGNtaHBibmRNYVRKa1dtNXRVM05ST1RabmRuUlVVVUp2TkVvMVFYWkdLM001U1d3clZIVnJaVXgwYkV0QlFtRnZUWGQ2T0hkWlFrTnVaa3QyVlhSckRRcHdOMHBWTldscWFsbEdZWEZSYzBaU00xSndUMGhZWTBndmMzQmFWRmxJZFZOek1VOXdTRlppY2pBdlkwWjBWMXB3ZGpSMFUxRnJiRkJ4UTJwa1pGTkJEUXBUU0Rsck0wOUNRV2g0Wlc1NVdFeHJiamxWT1VGQlNUTTBjRnBpUmxZcmJXdHpSMGR5VGpkMWEyczBiMkpUZEVrM2VpODFRV2ROUWtGQlIycFpla0pvRFFwTlFUaEhRVEZWWkVWM1JVSXZkMUZHVFVGTlFrRm1PSGRJZDFsRVZsSXdha0pDWjNkR2IwRlZjbUV6UzNOVWJsVldibGs0UzFobmJEQlNhV2xSUW5SdkRRcExSWGQzU0ZGWlJGWlNNRTlDUWxsRlJrSlpPRFY1UkhBeGNGUjJTQ3RYYVRoaWFqaDJkWEptVEVSbFFrMUJORWRCTVZWa1JIZEZRaTkzVVVWQmQwbENEUXBvYWtGT1FtZHJjV2hyYVVjNWR6QkNRVkZ6UmtGQlQwTkJaMFZCWlVsS2R6RnVibTlQY25OaGJYVmxWelJqV2xCTWVuSnVkVWhUUlhaMk1WTkZUREZpRFFwbVFqWkdOek5oYm0xNFluRTVLMDlaVnpaeGIycG9lSFp2Y2toVVJucHZVWGx1YzFCdFluTnZOM1EwWWpOSVFYUlhZVTlzY0RORVMxcFZWSEI2VDJ4TURRcHVVVGxuYzBSRVprUldVMHB6U2pWcWVHZHNSRVphYlRCQk1EZE1aRE5EZUZwb2JucFhaamxCTUZGblRuRk9OV2hEWTA5emNtdzBkVVJOZGxwNkswMDVEUXByVEM5cGEzTkRlRFJZTUhOdk1rOVRiVEZSWVd0eVlVRlNNM1Z0VUdNeWIyOUJZV05RYzBGV1EyeHNaV3RZUmtvNVJFWnFTalZWZGl0eVp6aGFTMGhJRFFwTVIzSlFNVGx2TDBGeldFcFpjRXRRTDNSMGF6VjBRblZCTkVwQ01qQmhVMmhpWTBNMU16bHlRU3RSWXl0clJFaDVVbTVNTUdGS2VWSlpaVUpuV1RGcERRcEJkSFY2V0hwTlQyczFNMWhXSzJGS2IyZEVjRE5uUmpjemN6RmpNVmw1U1ZKSWREZHZabEZITHpCYWJIZGpMelF4UTNoUFJDdHNlWHBITXpSU2EyZEpEUXBWVHpaVlptcHBSME5HVUcxYVVUSklhM0JMZVhGTWFXWnlZVkprY1hKSVdFOW9iMVprTjBocFpGbEphV2h1V2t0RWEweHBNV05tWlc4eWJYbzRkRmRwRFFwVmVrRXJaRkJqYUdGSlJXeHdVVXBRVkdwVFlreHFSakpKTVRsUmVVSTRablZRWVhwUVprNUpha2h5V0dGTGJHRlRNMngxUzJOR2FYRlBXV2RqZDFkbURRcGtXbTFFZW5oSlZUWlFXVEppZW5ndlUwUk5iMVV5TkhKQlZsTjFSMEZaUWtsQmJIZG1NbkI0YlhSTVkySk5RVFppV1hJMGRISnRVV1ppU25KTk9HWTREUXBLV21kSFVXOUpkSEp3ZW5KTGFrSktNbWRHVW5Rck1EWTFUazFVVG10Q05YSjNPRmh5TlRacU5XUnFhM0ZDTUM5eFNFbGpSakpVYVZrdmF5ODRNVkp0RFFwVVExbDRjbFpJZWsweFkzcG9XRWhZV1hwMmJtUXlTbXd4ZDBwWWVXRmpWMnczUm1sUVlXZG5kekJaVVdsa1YwaEhUV1JKZEVWMVJDODRVMWhwUTFoc0RRb3hUMGwyZG1salBRMEtMUzB0TFMxRlRrUWdRMFZTVkVsR1NVTkJWRVV0TFMwdExRMEsiLCJMUzB0TFMxQ1JVZEpUaUJEUlZKVVNVWkpRMEZVUlMwdExTMHREUXBOU1VsR1lsUkRRMEV4VjJkQmQwbENRV2RKU1VocWFtWlVkVk5xUm1wTmQwUlJXVXBMYjFwSmFIWmpUa0ZSUlV4Q1VVRjNVa1JGVmsxQ1RVZEJNVlZGRFFwQmQzZE5ZVlpPU1ZGV1NrWldSMVo2WkVWT1FrMVJNSGREZDFsRVZsRlJURVJCVWxWYVdFNHdUVkU0ZDBSUldVUldVVkZMUkVGYWNGVXdhRUpWYTFWNERRcERla0ZLUW1kT1ZrSkJXVlJCYXpWTlRVSTBXRVJVUlRSTlJHTjVUWHBGTVUxRVZYaE5NVzlZUkZSSk5FMUVZM2xOUkVVeFRVUlZlRTB4YjNkU1JFVldEUXBOUWsxSFFURlZSVUYzZDAxaFZrNUpVVlpLUmxaSFZucGtSVTVDVFZFd2QwTjNXVVJXVVZGTVJFRlNWVnBZVGpCTlVUaDNSRkZaUkZaUlVVdEVRVnB3RFFwVk1HaENWV3RWZUVONlFVcENaMDVXUWtGWlZFRnJOVTFOU1VsRFNXcEJUa0puYTNGb2EybEhPWGN3UWtGUlJVWkJRVTlEUVdjNFFVMUpTVU5EWjB0RERRcEJaMFZCTkVoSlVUSmxSMWhUVURCaWNXZFBjelpKWW5KNFZIY3ZNSFUyV0hsU2FUVklMMW9yYWpob1VIcEdaVk12YmpkVlkwUnpLelE0UjFsVFowVk9EUW94WTBsRVFrRkhWMnB1ZDA1Tk5uVTBVbkJSYVVjNGVHdzNXWFJxVjNsdGQwdHRORWhZZEV4QlVYRjBOekpoY2xrek4xQlRSak13V0drMlZsQkNZVzUwRFFwUVZHUmhZU3M1ZWtOVk9FTjVSbTVGV2pKbVMxUnJNVk4xWnpNMlp6WkdOazlxWkdkRFEwZHJhbVJ3Y0V0V2VVNUpiRFZQVnl0cmFrWnhNa0U1UjNaMERRcENVa2RGZDFJeVpYUnZkRXQwYzBsSVNTOW5OR05ZVDBaYWFuUkRRM1JRYjBWdGFsRTJObVpUZDJFM1FXcHZiSEJDWWpKUVkzTnpRMVp3WWpWak5uTkJEUXBtY0RJd1NrNXVPRFJyUkZGRmIwaHFaVzk1VGtGeFkzUkNSVWx6VWxwR05HdHdWRzQwV1doVFdIRXdWRWd2YTFKMFJVVm1Ua1Z0ZWt4RlQxTmhSRmRRRFFwNVREaHhTa3B3ZURGaFVFRjVaVEJtYTBkbVNtazFNV05IVW5KR2VHWTNhbVpPT1RsVWFtUm1NM2w0ZDNSVUwzbFJjWFZYVEhBMlZreGtjV3BLVEdzNURRcGlkRWRySzBKcFV6bHBWblIzTkRGRll6SjVjMWd2TTJjd2VHVldWa1pIZEhsRGQwRkRWM0I1U1hnclVXMDRNRXRxVmxocldVUjRhRWRwVEZGcVVVbDZEUXBXYjJ4UVJWWlZSRUZhYm5jclRFTnRaek5QV1RsSmVUQlFXRlJXTUhnelEwdElUU3RETTNWcldsZHJVekZrTTBOVFowUldiREVyWTNCSVNsUTBiVFptRFFwTGJtNWpUemMzZVZaUE1IbHlWelV5TVRoVlIyRlpRVXhQYURoUVNHOTNNelpsT1dOQ01tTXdZbFF5WkRGRFNGSmxhMU5zTkN0Q2VDdDRVVTFIZDNOUURRcDVkbVZIWjNCclNHbGtXblJaVWtSUU5FVXZTSGhPUzNrcmQyWkNlVkZsVTNVMFdXTlZZemhGU0hoNU9YRjZlR0ZsTWpoUlpscHVOM00wTjFZdlVHcEJEUXByTUdSTVdubFJSRzl1UlRsUk1UQlBhMDFXTVRWRWNEbFFWMGRsUTFGS2NtazFTbVJQYm5JcmFVUTRSR1JJYzBOQmQwVkJRV0ZPYWsxSFJYZEVkMWxFRFFwV1VqQlVRVkZJTDBKQlZYZEJkMFZDTDNwQlprSm5UbFpJVTAxRlIwUkJWMmRDVTNSeVkzRjRUMlJTVjJScWQzQmxRMWhTUjB0S1FVY3laMjlVUkVGa0RRcENaMDVXU0ZFMFJVWm5VVlZ5WVROTGMxUnVWVlp1V1RoTFdHZHNNRkpwYVZGQ2RHOUxSWGQzUkdkWlJGWlNNRkJCVVVndlFrRlJSRUZuUjBkTlFUQkhEUXBEVTNGSFUwbGlNMFJSUlVKRGQxVkJRVFJKUTBGUlFrTkhXVTVzTHpGSVJsZFdhRVJ2VUcxcmNGWnhiVE13Y25seFpqWmtWM2d4Y25oVVZ6RnNhemxoRFFwV1ZVOXNVamxKVWtoUWNERjZMMFl2TkdaaU5tMUpXRVpxUmxsM05XeFZNbVpoU0ZZNWIzQTBjazUxUjNGU1VsTk1hVkZRVm5aUFdIaEViSGh4UVRaRURRcHRjWHBwVWtWMmRIUkhNSFZNV2k5R1QzbGpTMWsxTTNCWFJrTjZSekpyWlhFMlQwbGtPVXBUY0VadFVVUlBhVVkzVjFOMWFXWlFUSFYzUVVSclZYY3JEUXB2V2xsSFoxZHRZbmRSVHpCc1dIUjNOMWhQYm5rek4yNU1XbXRaYkRnNVlsSm9TV2N2TjJaaUsxaHVZamc1TVRSVFRYWXdhMGRzYXpGclEyVjVURFpHRFFwWVpGaFNWR0ZoZERWak9WaHNTbkk1ZVhwUFZVbEVialUwWWxreFFrdFVObGwwYVhsS1puWkRUbUYyTDBaaU1qUjJOV1Z4TWxvNWJVSmtXamN3UTJNNURRbzFaMUJxY1hGNFRWcFZaMHB2TlRkWmRtaE1abGhFZDNoaVYxcFhXVU1yVjJOU09HNUlhMWtyZEZwQ2JFbHBhREpEV0VoelQyRnlOVzlJTm1SeVRXUjBEUXBOU1ZwNk0xVmFTaTlEZUVaSE1YVXlNMVY2TVdwQ1ptMHZSV2RuWkV0b1QxWnVWRFpsWkhKMVZtOTBaVmRYUTBSQ09VaGthSGg2T0ZKQlZsbHVOV1J4RFFwVmFtdHFVbkUwVnpsUlFXWktkWE55VUZwSFFtNWtWRGQ1VG1GWkwwWklXVXRKY1N0MVZHRnlWMmxpYW1SNGRHUlpRMnhoVkhkUGVHczFTWEZMVGtZNURRcGxRMHRpVUcxNGN6RnRiRnB5VTB4cVRWRkdXVE5WT1ZKcmRucEpLek5KYkVGR2EyTjBWV1ZoWW5CcmJWaDRiblZYVjFOV01rWktUemxhY2s5T1RWZDFEUXAwZHlzMU5qZFFTelZuZWswd1JuRlJkbUkzYzBONFduVlJSR3cxUTNRMldsZHNkSE15V1RjeWREWndVR3BTU1RFM0sxTTRLeXRoTW5aUlpIaENZMDVSRFFvd2VFWXlkR3AyZWxSMmFWb3pRelZGY1VsbFlYcFhaR2RKV210eFpsZGFhMU00ZGlzd1RVRjJUbHBaSzJKaWVDdDJVM2RNVDI5SVVWZHlaaTlQUTB3M0RRcEJVVDA5RFFvdExTMHRMVVZPUkNCRFJWSlVTVVpKUTBGVVJTMHRMUzB0RFFvPSJdLCJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAzIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMyIsImp0aSI6IjcwNzFlY2M1MTU0NDQxMjc5OTAzNjIyYWYxYmVkYmMwIiwiaWF0IjoxNTkxOTY1Mjc3LCJleHAiOjE1OTE5NjUzMDcsImNhcGFiaWxpdGllc19pbmZvIjp7InBhcnR5X2lkIjoiRVUuRU9SSS5OTDAwMDAwMDAwMyIsImlzaGFyZV9yb2xlcyI6W3sicm9sZSI6IlNlcnZpY2UgUHJvdmlkZXIifV0sInN1cHBvcnRlZF92ZXJzaW9ucyI6W3sidmVyc2lvbiI6IjEuNyIsInN1cHBvcnRlZF9mZWF0dXJlcyI6W3sicHVibGljIjpbeyJpZCI6IkE1MUQ0MTNGLUIzQ0MtNDc3RC05NkM0LUUzN0E5MDAzQkZFMyIsImZlYXR1cmUiOiJjYXBhYmlsaXRpZXMiLCJkZXNjcmlwdGlvbiI6IlJldHJpZXZlcyBpU0hBUkUgY2FwYWJpbGl0aWVzIiwidXJsIjoiaHR0cHM6Ly93MTMuaXNoYXJldGVzdC5uZXQvY2FwYWJpbGl0aWVzIiwidG9rZW5fZW5kcG9pbnQiOiJodHRwczovL3cxMy5pc2hhcmV0ZXN0Lm5ldC9jb25uZWN0L3Rva2VuIn0seyJpZCI6IjQ5RjZFNjYyLUYwNTUtNEFBQy05NkIyLUU4MzNGQTVGNTQxNCIsImZlYXR1cmUiOiJhY2Nlc3MgdG9rZW4iLCJkZXNjcmlwdGlvbiI6Ik9idGFpbnMgYWNjZXNzIHRva2VuIiwidXJsIjoiaHR0cHM6Ly93MTMuaXNoYXJldGVzdC5uZXQvY29ubmVjdC90b2tlbiJ9LHsiaWQiOiIwNTM1N0IxQy1BOTM0LTRCQjItQTdDRC00Mjk0OERBNTIzNzkiLCJmZWF0dXJlIjoiYm9vbSBhY2Nlc3MiLCJkZXNjcmlwdGlvbiI6IlJlcXVlc3QgYm9vbSBhY2Nlc3MgYmFzZWQgb24gdXNlciBpbmZvcm1hdGlvbiIsInVybCI6Imh0dHBzOi8vdzEzLmlzaGFyZXRlc3QubmV0L2Jvb21fYWNjZXNzIiwidG9rZW5fZW5kcG9pbnQiOiJodHRwczovL3cxMy5pc2hhcmV0ZXN0Lm5ldC9jb25uZWN0L3Rva2VuIn0seyJpZCI6IjEwNUQxOUM3LTAyQjEtNDgxRi04Qjk4LTBDMEYyRjVFQkI0QiIsImZlYXR1cmUiOiJyZXR1cm4gY2xpZW50IGluZm9ybWF0aW9uIiwiZGVzY3JpcHRpb24iOiJEaXNwbGF5cyBpZGVudGl0eSBvZiBjbGllbnQgdG8gd2hpY2ggYWNjZXNzIHRva2VuIHdhcyBpc3N1ZWQiLCJ1cmwiOiJodHRwczovL3cxMy5pc2hhcmV0ZXN0Lm5ldC9tZSIsInRva2VuX2VuZHBvaW50IjoiaHR0cHM6Ly93MTMuaXNoYXJldGVzdC5uZXQvY29ubmVjdC90b2tlbiJ9XX1dfV19fQ.SpxDw3Yc7RTR7vudzfvc5ys3BgkJOdnS41A5B1KHAy4Po3leHrsu4bXYNWi44Ln-kaihRw1zAoJ8UW9YO3nezlwSixEGgxDlNvmYBnhHe_BIpLIb-j-b1Y_oQCjM-5AtZpXeXbHA9lmt-YSumEEsP-Bkhu_Tenwi6r9fMsPTjKB8KiPljp7XYSUm7cgmg82VSQzdd2Ft-8FC6qTyoShVTcP6KqcHVPlKeJCa92yXi2gg6sUsrMYiA3ol7R9diyDXdWNghSkkoBLZHoWpj9DGlTFVgrwuWyF72Y0wQs9l4QAcnbdxPQXcemzazam1aE4f8auKj-gt49KSBo-TggrXcA"
    }

Decoded JWT Payload
^^^^^^^^^^^^^^^^^^^

.. code-block:: json

    {
      "iss": "EU.EORI.NL000000003",
      "sub": "EU.EORI.NL000000003",
      "jti": "7071ecc5154441279903622af1bedbc0",
      "iat": 1591965277,
      "exp": 1591965307,
      "capabilities_info": {
        "party_id": "EU.EORI.NL000000003",
        "ishare_roles": [
          {
            "role": "ServiceProvider"
          }
        ],
        "supported_versions": [
          {
            "version": "1.7",
            "supported_features": [
              {
                "public": [
                  {
                    "id": "A51D413F-B3CC-477D-96C4-E37A9003BFE3",
                    "feature": "capabilities",
                    "description": "Retrieves iSHARE capabilities",
                    "url": "https://w13.isharetest.net/capabilities",
                    "token_endpoint": "https://w13.isharetest.net/connect/token"
                  },
                  {
                    "id": "49F6E662-F055-4AAC-96B2-E833FA5F5414",
                    "feature": "access token",
                    "description": "Obtains access token",
                    "url": "https://w13.isharetest.net/connect/token"
                  },
                  {
                    "id": "05357B1C-A934-4BB2-A7CD-42948DA52379",
                    "feature": "boom access",
                    "description": "Request boom access based on user information",
                    "url": "https://w13.isharetest.net/boom_access",
                    "token_endpoint": "https://w13.isharetest.net/connect/token"
                  },
                  {
                    "id": "105D19C7-02B1-481F-8B98-0C0F2F5EBB4B",
                    "feature": "return client information",
                    "description": "Displays identity of client to which access token was issued",
                    "url": "https://w13.isharetest.net/me",
                    "token_endpoint": "https://w13.isharetest.net/connect/token"
                  }
                ]
              }
            ]
          }
        ]
      }
    }