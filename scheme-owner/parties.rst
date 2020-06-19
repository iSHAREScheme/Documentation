.. _refParties:

Parties
=======

Used to obtain information about iSHARE participants from the iSHARE Scheme owner. Should be used to verify the status of an iSHARE participants. Returns 10 records per page. Furthermore offers limited search functionality through optional parameters, at least one optional parameter is required.

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

``name``
    | **String**. *Optional*.
    | Optional parameter used to search by party's name. Can contain a single * as wildcard.

``eori``
    | **String**. *Optional*.
    | Optional parameter used to search by party's EORI. Can contain a single * as wildcard.

``certified_only``
    | **Boolean**. *Optional*.
    | Optional parameter used to search all certified parties. If null is provided, then it won't affect the query and will return both certified and non certified parties. If false is provided, then the query will return non certified parties. If true is provided, then query will return certified parties.

``active_only``
    | **Boolean**. *Optional*.
    | Optional parameter used to search all active parties. If null is provided, then it won't affect the query and will return both active and inactive parties. If false is provided, then the query will return inactive parties. If true is provided, then query will return active parties.

``certificate_subject_name``
    | **String**. *Optional*.
    | subjectName as encoded in the X.509 certificate which corresponds with the party that is being requested from the Scheme Owner. Used by the Scheme Owner to match the certificate identifier. Subject name attributes may be in any order, but all of them must be included and separated by comma, if at least one subject attribute is missing - information won't be returned. Only returns info if combined with the valid ``eori`` associated to it.

``page``
    | **Integer**. *Optional*.
    | Optional parameter used for navigation in case the result contains more than 10 parties.

``date_time``
    | **String (ISO 8601)**. *Optional*.
    | Date time for which the information is requested. If provided the result becomes final and therefore MUST be cacheable.

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
        | Collection of parties. Party info definition can be found at :ref:`party endpoint section<refPartyInfo>`.

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/json

    {
      "parties_token": "eyJ4NWMiOlsiTUlJRWlEQ0NBbkNnQXdJQkFnSUllRElyZG5ZbzJuZ3dEUVlKS29aSWh2Y05BUUVMQlFBd1NERVpNQmNHQTFVRUF3d1FhVk5JUVZKRlZHVnpkRU5CWDFSTVV6RU5NQXNHQTFVRUN3d0VWR1Z6ZERFUE1BMEdBMVVFQ2d3R2FWTklRVkpGTVFzd0NRWURWUVFHRXdKT1REQWVGdzB4T1RBeU1UVXhNVFEyTlRoYUZ3MHlNVEF5TVRReE1UUTJOVGhhTUVreEhEQWFCZ05WQkFNTUUybFRTRUZTUlNCVFkyaGxiV1VnVDNkdVpYSXhIREFhQmdOVkJBVVRFMFZWTGtWUFVra3VUa3d3TURBd01EQXdNREF4Q3pBSkJnTlZCQVlUQWs1TU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBMFJvb2hlUEwwMk52NEJaVEoza3A3bktzaHNtanJjcjhNQmFBaFFwWlpBc2dUQWxtUWlDVFBtM2M4cVlQcU4rVHVnZ0ZXQ05uKzlXNTRDNVVHcXNJd3RYVGszWWV4QXdaNG9qUlJ0bzhsMUhQRFZBUzZXdlc3NEFDTlpsRWdHd2pyQ0d5MitNNVFQN083d0IwVDZvRkJvZlJ3SFpHemdidFNiU1FodXF3VXhmMEdaSTh4QWwyL0dUSDI1VmZwOVQ3MUpFcG9aOWtzUDNDSWk1QkhrbGJUNUdLeEVPRmZkTU11cFg3bVduTlFiTHh1UXBBdEdDdW9yR2ZQRkU3RjVldkUxem9wd2NlQTVGc0UxTGFCUnF0K0VPcFBJbVNhalIwMmJjaEs5alM2bllFV3MvRlpHTHRKYWxsNUwzU25aTTZPaFd4TStsS0d6Rkt3NVRJWE45RE13SURBUUFCbzNVd2N6QU1CZ05WSFJNQkFmOEVBakFBTUI4R0ExVWRJd1FZTUJhQUZCWTg1eURwMXBUdkgrV2k4Ymo4dnVyZkxEZUJNQk1HQTFVZEpRUU1NQW9HQ0NzR0FRVUZCd01CTUIwR0ExVWREZ1FXQkJSZndpalQ3NWRJS1BsRkMvQ3RSRHFVS1g5VE5qQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFLNFBXVHEvZHF0Vm0rNFdDZDFLUUo0dGorbjRjY0lBWUxETXFZU0JKc042UTJjdE1SQy8rK3lNL293UEhCcmlUendXL2pvQXBOUGVaaDFJVFRnU3phMzhtM2h4b0RxMXV4NkhWR3lLNVFDUW9qRmRsZWM3dE9IbG1jYnV5VjRDRXlNWmJHK3lMbVZESTNxNTNWQVBnV3ZLSWkyUlVwc1BOdzJsbzZINjZ2SE5wNWZpcEIvdEU0Q0RsYS9UYU41MWxOM2xYT3c0bHRiWmJ6YmQ2TXhJbEVDUWZKSDVlUHJpcGFrSmhuaVZrWnZRVmthS0FlcFNYMGFEWUxPcFFRbmV0RFdab1ZKS0FzR0VMM0hMaWhxWXNEejcvQlQzRHdUMEtDNSs5OGdqR1p3dkx3ZXRKOTZLWFRBRTUwMmYzak95UDdERDZ1SytKS2d2UVp5dkk1L0V1cDBUdE5sUmZKeThhZDhweCszOG9JeEdBbGJzS29XbXowb2FNR0MrbFZHTlAyTTQ4TTdWa3RCVHB5bXF4Vnd0VGt2TVBqWldIS2xYdDJXMzNtTktHakpTOTVJNXZxT0tQV1NTc1dkSlJZSkNsbUVybWlkTlczMWxXQVZQcjFpU1M0SlhEdllQTENQNDRhNGVkMEdhV1pSdi9iK0QyK1FVZ09iOFN6bWpQdmYvMkdOdHFXUmR5WXRYWjl2eDAzNGkrWEYveWU4c2lOK1grd0ZIdFJ1bXRzd2Irc2NRZjRmVTZNaktCS1VzUERBUkFHakhqNXhIQkRqcTg0bmpHdVFjbDBoYlMzK1pTVjROcWtKSVVzMkxVdDlFdjFYN2FCNy85NUVYQWNnTlhkM0tQVm0zcDhORDc1QXFNMEZHUUVhUXlPd3FLY3FUQ2xKQ3VmR3NVWTRzN3JXUiIsIkxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdERRcE5TVWxHWTFSRFEwRXhiV2RCZDBsQ1FXZEpTVk5HVWtwM1IwRkJlV3BWZDBSUldVcExiMXBKYUhaalRrRlJSVXhDVVVGM1VrUkZWazFDVFVkQk1WVkZEUXBCZDNkTllWWk9TVkZXU2taV1IxWjZaRVZPUWsxUk1IZERkMWxFVmxGUlRFUkJVbFZhV0U0d1RWRTRkMFJSV1VSV1VWRkxSRUZhY0ZVd2FFSlZhMVY0RFFwRGVrRktRbWRPVmtKQldWUkJhelZOVFVJMFdFUlVSVFJOUkdONVRYcEZNVTFVVVhoTk1XOVlSRlJKZWsxRVkzbE5ha1V4VFZSUmVFMHhiM2RUUkVWYURRcE5RbU5IUVRGVlJVRjNkMUZoVms1SlVWWktSbFpIVm5wa1JVNUNXREZTVFZWNlJVNU5RWE5IUVRGVlJVTjNkMFZXUjFaNlpFUkZVRTFCTUVkQk1WVkZEUXBEWjNkSFlWWk9TVkZXU2taTlVYTjNRMUZaUkZaUlVVZEZkMHBQVkVSRFEwRnBTWGRFVVZsS1MyOWFTV2gyWTA1QlVVVkNRbEZCUkdkblNWQkJSRU5ERFFwQloyOURaMmRKUWtGUWRXVlNXRlZIVTFWbmRUZHhjRUZYU21wQlZrZzVlak14T1ZodWRVWnNaVlpsVHk5WWVHSktObFUwYVhoWVVrdDJWemgyUzFSV0RRb3haRkpqWmxGbFEzRllhemQxWVM5YWMzRk9jbkU0T1VWNE9UVmlNRzV4UjFWMk1VNXZTekpVT0hsRlFXdFJlbmw2V1Zwd1Z6UmpNbGxOUTJObk5XRnREUXBTZDBObVdXRm9TSFJLYlZoS1YzRlNSV1YyVFRWclNtOVBZV05MU0M5SFZXSnpaVzFVT1RSQ01FdFlVMDVSTmtsWFkwcDVhbkIxWVc5RWNHSTJWMlE1RFFvM1ZESnNkVkF4U1ZFMVoydG1kMVV6T0VOYVNrdFdhMkpaTTJWS2EweHNUM2QzZEVaelJsQlFNazAwWmpoMU5EYzVUMnROVlhJMUwyMHJlRzQzTTBwaERRcGFVMHBHVDBoMlNVNDJSRVp3UVd4ek1tRjROMEpvVlZOc1lrdE5NMWxGZFU1aU1FODBiMDgxZVc1RVJraDJiV3hzY0RaT2RUQkdNbGh2TUVKMU1GQXZEUXAxY1dJdk1EaFlkbFpYYm1VM2QyTjNWMXBTT1N0a056aHhLMDlzWmtNdmJTdDNRWGRCY1cxUlNFVnlPR2hLVG5aU05sTXZPRFJJUVdwVlpFMTVSMk5aRFFwVWRtOTJNSFJpTUZwM0wwRkxkMFJuT0ZCRE9WVkdVbGxpTUdOQ2NqQXJMMGRtWjIxS1VEVlJUVUZtVEhGcldHMWFkMWxSVTFveFJtRnRUbXhLYkcxNERRb3djMWxhVVZOaGRXUkhNQ3RZYTJNNU9URXJXbmN2ZURoMVYxcHBPWEZSV21WQ1QyUjNia2t5ZUdZdlNFcFlTRXB6WVZwbVJIWlVjRFZwT0dsV1VEYzFEUW94Y21ocGJuZE1hVEprV201dFUzTlJPVFpuZG5SVVVVSnZORW8xUVhaR0szTTVTV3dyVkhWclpVeDBiRXRCUW1GdlRYZDZPSGRaUWtOdVprdDJWWFJyRFFwd04wcFZOV2xxYWxsR1lYRlJjMFpTTTFKd1QwaFlZMGd2YzNCYVZGbElkVk56TVU5d1NGWmljakF2WTBaMFYxcHdkalIwVTFGcmJGQnhRMnBrWkZOQkRRcFRTRGxyTTA5Q1FXaDRaVzU1V0V4cmJqbFZPVUZCU1RNMGNGcGlSbFlyYld0elIwZHlUamQxYTJzMGIySlRkRWszZWk4MVFXZE5Ra0ZCUjJwWmVrSm9EUXBOUVRoSFFURlZaRVYzUlVJdmQxRkdUVUZOUWtGbU9IZElkMWxFVmxJd2FrSkNaM2RHYjBGVmNtRXpTM05VYmxWV2JsazRTMWhuYkRCU2FXbFJRblJ2RFFwTFJYZDNTRkZaUkZaU01FOUNRbGxGUmtKWk9EVjVSSEF4Y0ZSMlNDdFhhVGhpYWpoMmRYSm1URVJsUWsxQk5FZEJNVlZrUkhkRlFpOTNVVVZCZDBsQ0RRcG9ha0ZPUW1kcmNXaHJhVWM1ZHpCQ1FWRnpSa0ZCVDBOQlowVkJaVWxLZHpGdWJtOVBjbk5oYlhWbFZ6UmpXbEJNZW5KdWRVaFRSWFoyTVZORlRERmlEUXBtUWpaR056TmhibTE0WW5FNUswOVpWelp4YjJwb2VIWnZja2hVUm5wdlVYbHVjMUJ0WW5Odk4zUTBZak5JUVhSWFlVOXNjRE5FUzFwVlZIQjZUMnhNRFFwdVVUbG5jMFJFWmtSV1UwcHpTalZxZUdkc1JFWmFiVEJCTURkTVpETkRlRnBvYm5wWFpqbEJNRkZuVG5GT05XaERZMDl6Y213MGRVUk5kbHA2SzAwNURRcHJUQzlwYTNORGVEUllNSE52TWs5VGJURlJZV3R5WVVGU00zVnRVR015YjI5QllXTlFjMEZXUTJ4c1pXdFlSa281UkVacVNqVlZkaXR5WnpoYVMwaElEUXBNUjNKUU1UbHZMMEZ6V0VwWmNFdFFMM1IwYXpWMFFuVkJORXBDTWpCaFUyaGlZME0xTXpseVFTdFJZeXRyUkVoNVVtNU1NR0ZLZVZKWlpVSm5XVEZwRFFwQmRIVjZXSHBOVDJzMU0xaFdLMkZLYjJkRWNETm5SamN6Y3pGak1WbDVTVkpJZERkdlpsRkhMekJhYkhkakx6UXhRM2hQUkN0c2VYcEhNelJTYTJkSkRRcFZUelpWWm1wcFIwTkdVRzFhVVRKSWEzQkxlWEZNYVdaeVlWSmtjWEpJV0U5b2IxWmtOMGhwWkZsSmFXaHVXa3RFYTB4cE1XTm1aVzh5YlhvNGRGZHBEUXBWZWtFclpGQmphR0ZKUld4d1VVcFFWR3BUWWt4cVJqSkpNVGxSZVVJNFpuVlFZWHBRWms1SmFraHlXR0ZMYkdGVE0yeDFTMk5HYVhGUFdXZGpkMWRtRFFwa1dtMUVlbmhKVlRaUVdUSmllbmd2VTBSTmIxVXlOSEpCVmxOMVIwRlpRa2xCYkhkbU1uQjRiWFJNWTJKTlFUWmlXWEkwZEhKdFVXWmlTbkpOT0dZNERRcEtXbWRIVVc5SmRISndlbkpMYWtKS01tZEdVblFyTURZMVRrMVVUbXRDTlhKM09GaHlOVFpxTldScWEzRkNNQzl4U0VsalJqSlVhVmt2YXk4NE1WSnREUXBVUTFsNGNsWkllazB4WTNwb1dFaFlXWHAyYm1ReVNtd3hkMHBZZVdGalYydzNSbWxRWVdkbmR6QlpVV2xrVjBoSFRXUkpkRVYxUkM4NFUxaHBRMWhzRFFveFQwbDJkbWxqUFEwS0xTMHRMUzFGVGtRZ1EwVlNWRWxHU1VOQlZFVXRMUzB0TFEwSyIsIkxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdERRcE5TVWxHWWxSRFEwRXhWMmRCZDBsQ1FXZEpTVWhxYW1aVWRWTnFSbXBOZDBSUldVcExiMXBKYUhaalRrRlJSVXhDVVVGM1VrUkZWazFDVFVkQk1WVkZEUXBCZDNkTllWWk9TVkZXU2taV1IxWjZaRVZPUWsxUk1IZERkMWxFVmxGUlRFUkJVbFZhV0U0d1RWRTRkMFJSV1VSV1VWRkxSRUZhY0ZVd2FFSlZhMVY0RFFwRGVrRktRbWRPVmtKQldWUkJhelZOVFVJMFdFUlVSVFJOUkdONVRYcEZNVTFFVlhoTk1XOVlSRlJKTkUxRVkzbE5SRVV4VFVSVmVFMHhiM2RTUkVWV0RRcE5RazFIUVRGVlJVRjNkMDFoVms1SlVWWktSbFpIVm5wa1JVNUNUVkV3ZDBOM1dVUldVVkZNUkVGU1ZWcFlUakJOVVRoM1JGRlpSRlpSVVV0RVFWcHdEUXBWTUdoQ1ZXdFZlRU42UVVwQ1owNVdRa0ZaVkVGck5VMU5TVWxEU1dwQlRrSm5hM0ZvYTJsSE9YY3dRa0ZSUlVaQlFVOURRV2M0UVUxSlNVTkRaMHRERFFwQlowVkJORWhKVVRKbFIxaFRVREJpY1dkUGN6WkpZbko0Vkhjdk1IVTJXSGxTYVRWSUwxb3JhamhvVUhwR1pWTXZiamRWWTBSekt6UTRSMWxUWjBWT0RRb3hZMGxFUWtGSFYycHVkMDVOTm5VMFVuQlJhVWM0ZUd3M1dYUnFWM2x0ZDB0dE5FaFlkRXhCVVhGME56SmhjbGt6TjFCVFJqTXdXR2syVmxCQ1lXNTBEUXBRVkdSaFlTczVla05WT0VONVJtNUZXakptUzFSck1WTjFaek0yWnpaR05rOXFaR2REUTBkcmFtUndjRXRXZVU1SmJEVlBWeXRyYWtaeE1rRTVSM1owRFFwQ1VrZEZkMUl5WlhSdmRFdDBjMGxJU1M5bk5HTllUMFphYW5SRFEzUlFiMFZ0YWxFMk5tWlRkMkUzUVdwdmJIQkNZakpRWTNOelExWndZalZqTm5OQkRRcG1jREl3U2s1dU9EUnJSRkZGYjBocVpXOTVUa0Z4WTNSQ1JVbHpVbHBHTkd0d1ZHNDBXV2hUV0hFd1ZFZ3ZhMUowUlVWbVRrVnRla3hGVDFOaFJGZFFEUXA1VERoeFNrcHdlREZoVUVGNVpUQm1hMGRtU21rMU1XTkhVbkpHZUdZM2FtWk9PVGxVYW1SbU0zbDRkM1JVTDNsUmNYVlhUSEEyVmt4a2NXcEtUR3M1RFFwaWRFZHJLMEpwVXpscFZuUjNOREZGWXpKNWMxZ3ZNMmN3ZUdWV1ZrWkhkSGxEZDBGRFYzQjVTWGdyVVcwNE1FdHFWbGhyV1VSNGFFZHBURkZxVVVsNkRRcFdiMnhRUlZaVlJFRmFibmNyVEVOdFp6TlBXVGxKZVRCUVdGUldNSGd6UTB0SVRTdERNM1ZyV2xkclV6RmtNME5UWjBSV2JERXJZM0JJU2xRMGJUWm1EUXBMYm01alR6YzNlVlpQTUhseVZ6VXlNVGhWUjJGWlFVeFBhRGhRU0c5M016WmxPV05DTW1Nd1lsUXlaREZEU0ZKbGExTnNOQ3RDZUN0NFVVMUhkM05RRFFwNWRtVkhaM0JyU0dsa1duUlpVa1JRTkVVdlNIaE9TM2tyZDJaQ2VWRmxVM1UwV1dOVll6aEZTSGg1T1hGNmVHRmxNamhSWmxwdU4zTTBOMVl2VUdwQkRRcHJNR1JNV25sUlJHOXVSVGxSTVRCUGEwMVdNVFZFY0RsUVYwZGxRMUZLY21rMVNtUlBibklyYVVRNFJHUkljME5CZDBWQlFXRk9hazFIUlhkRWQxbEVEUXBXVWpCVVFWRklMMEpCVlhkQmQwVkNMM3BCWmtKblRsWklVMDFGUjBSQlYyZENVM1J5WTNGNFQyUlNWMlJxZDNCbFExaFNSMHRLUVVjeVoyOVVSRUZrRFFwQ1owNVdTRkUwUlVablVWVnlZVE5MYzFSdVZWWnVXVGhMV0dkc01GSnBhVkZDZEc5TFJYZDNSR2RaUkZaU01GQkJVVWd2UWtGUlJFRm5SMGROUVRCSERRcERVM0ZIVTBsaU0wUlJSVUpEZDFWQlFUUkpRMEZSUWtOSFdVNXNMekZJUmxkV2FFUnZVRzFyY0ZaeGJUTXdjbmx4Wmpaa1YzZ3hjbmhVVnpGc2F6bGhEUXBXVlU5c1VqbEpVa2hRY0RGNkwwWXZOR1ppTm0xSldFWnFSbGwzTld4Vk1tWmhTRlk1YjNBMGNrNTFSM0ZTVWxOTWFWRlFWblpQV0hoRWJIaHhRVFpFRFFwdGNYcHBVa1YyZEhSSE1IVk1XaTlHVDNsalMxazFNM0JYUmtONlJ6SnJaWEUyVDBsa09VcFRjRVp0VVVSUGFVWTNWMU4xYVdaUVRIVjNRVVJyVlhjckRRcHZXbGxIWjFkdFluZFJUekJzV0hSM04xaFBibmt6TjI1TVdtdFpiRGc1WWxKb1NXY3ZOMlppSzFodVlqZzVNVFJUVFhZd2EwZHNhekZyUTJWNVREWkdEUXBZWkZoU1ZHRmhkRFZqT1Zoc1NuSTVlWHBQVlVsRWJqVTBZbGt4UWt0VU5sbDBhWGxLWm5aRFRtRjJMMFppTWpSMk5XVnhNbG81YlVKa1dqY3dRMk01RFFvMVoxQnFjWEY0VFZwVlowcHZOVGRaZG1oTVpsaEVkM2hpVjFwWFdVTXJWMk5TT0c1SWExa3JkRnBDYkVscGFESkRXRWh6VDJGeU5XOUlObVJ5VFdSMERRcE5TVnA2TTFWYVNpOURlRVpITVhVeU0xVjZNV3BDWm0wdlJXZG5aRXRvVDFadVZEWmxaSEoxVm05MFpWZFhRMFJDT1Voa2FIaDZPRkpCVmxsdU5XUnhEUXBWYW10cVVuRTBWemxSUVdaS2RYTnlVRnBIUW01a1ZEZDVUbUZaTDBaSVdVdEpjU3QxVkdGeVYybGlhbVI0ZEdSWlEyeGhWSGRQZUdzMVNYRkxUa1k1RFFwbFEwdGlVRzE0Y3pGdGJGcHlVMHhxVFZGR1dUTlZPVkpyZG5wSkt6TkpiRUZHYTJOMFZXVmhZbkJyYlZoNGJuVlhWMU5XTWtaS1R6bGFjazlPVFZkMURRcDBkeXMxTmpkUVN6Vm5lazB3Um5GUmRtSTNjME40V25WUlJHdzFRM1EyV2xkc2RITXlXVGN5ZERad1VHcFNTVEUzSzFNNEt5dGhNblpSWkhoQ1kwNVJEUW93ZUVZeWRHcDJlbFIyYVZvelF6VkZjVWxsWVhwWFpHZEpXbXR4WmxkYWExTTRkaXN3VFVGMlRscFpLMkppZUN0MlUzZE1UMjlJVVZkeVppOVBRMHczRFFwQlVUMDlEUW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHREUW89Il0sImFsZyI6IlJTMjU2IiwidHlwIjoiSldUIn0.eyJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAwIiwic3ViIjoiRVUuRU9SSS5OTDAwMDAwMDAwMCIsImp0aSI6IjA4Njg5MDRkOGVkOTRjMDFhMGE0ZDZkZDVjNjVjZTllIiwiaWF0IjoxNTkxOTY1OTA1LCJleHAiOjE1OTE5NjU5MzUsImF1ZCI6IkVVLkVPUkkuTkwwMDAwMDAwMDEiLCJwYXJ0aWVzX2luZm8iOnsiY291bnQiOjEsImRhdGEiOlt7InBhcnR5X2lkIjoiRVUuRU9SSS5OTDAwMDAwMDAwNCIsInBhcnR5X25hbWUiOiJBc2tNZUFueXRoaW5nIEF1dGhvcml6YXRpb24gUmVnaXN0cnkiLCJhZGhlcmVuY2UiOnsic3RhdHVzIjoiQWN0aXZlIiwic3RhcnRfZGF0ZSI6IjIwMTgtMDQtMjZUMTQ6NTk6MTRaIiwiZW5kX2RhdGUiOiIyMDIwLTA3LTI1VDE0OjU5OjE0WiJ9LCJjZXJ0aWZpY2F0aW9ucyI6W3sicm9sZSI6IkF1dGhvcmlzYXRpb25SZWdpc3RyeSIsInN0YXJ0X2RhdGUiOiIyMDE4LTAxLTA0VDAwOjAwOjAwWiIsImVuZF9kYXRlIjoiMjAyMC0wMi0wMlQwMDowMDowMFoiLCJsb2EiOjN9XX1dfX0.rwNcyK_4h2eA8ZjYC5NBLWTegwQH_e3CJTDrjX3s9dcykekJ5ri7iGf4GPuEJpbXDUI2FgV00IuqW2UkznQsDsw0HDejJLZ9PJGxQXlSC4-r3Lbx9SSuVAk4uTClOdnAYgtpwWyjXLTYHbWb1fj9-xqjZ851CmRtp2rOWOSRXWYLmjG7s0fwTFNyy4C03trEmnelk3jyQkZCNRhFeflIywNLSBPPo5MqKEz3Fe3AxpKybuPRMVotWaCQvROUws99m7dUIXSpD8mUYomtOalDJ_2LJffHfLXqEoWkQTKmru_hboNJhrveg7PfziXrxruGO07Mn4ZqwH-RxOMTxY_aaQ"
    }

Decoded JWT Payload
^^^^^^^^^^^^^^^^^^^

.. code-block:: json

    {
      "iss": "EU.EORI.NL000000000",
      "sub": "EU.EORI.NL000000000",
      "jti": "0868904d8ed94c01a0a4d6dd5c65ce9e",
      "iat": 1591965905,
      "exp": 1591965935,
      "aud": "EU.EORI.NL000000001",
      "parties_info": {
        "count": 1,
        "data": [
          {
            "party_id": "EU.EORI.NL000000004",
            "party_name": "AskMeAnything Authorization Registry",
            "adherence": {
              "status": "Active",
              "start_date": "2018-04-26T14:59:14Z",
              "end_date": "2020-07-25T14:59:14Z"
            },
            "certifications": [
              {
                "role": "AuthorisationRegistry",
                "start_date": "2018-01-04T00:00:00Z",
                "end_date": "2020-02-02T00:00:00Z",
                "loa": 3
              }
            ]
          }
        ]
      }
    }