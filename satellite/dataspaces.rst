.. _refDataspaces:

Dataspaces
============

Used to obtain list of dataspaces. 

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

Example
~~~~~~~

::

    > Authorization: Bearer IIeDIrdnYo2ngwDQYJKoZIhvcNAQELBQAwSDEZMBcGA1UEAwwQaVNIQ

    GET /dataspaces

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

Parameters
~~~~~~~~~~

``dataspace_list_token``
    | **String (JWT)**.
    | A signed JWT which contains information about list of dataspaces. The response is returned as page of 10 records at a time.

**Decoded dataspace_list_token parameters:**

It contains :ref:`iSHARE compliant JWT claims<refJWTPayload>`. In addition to that it also contains the following parameters:

``dataspace_info``
    | **Array of Objects**. Root level.
    | Contains results counts and information about dataspaces.

    ``total_count``
        | **Integer**. Contained in the object of ``dataspace_info``.
        | Total count of found dataspaces.
    ``pageCount``
        | **Integer**. Contained in the object of ``dataspace_info``.
        | Number of pages (10 per page).
    ``count``
        | **Integer**. Contained in the object of ``dataspace_info``.
        | Number of dataspaces returned.

    ``data``
        | **Array of Objects**. Contained in the object of ``dataspace_list_token``.
        | Array containing a collection of data space objects.

            ``dataspace_title``
                | **String**. Contained in the object of ``data``.
                | Title of dataspace.
            ``dataspace_id``
                | **String**. Contained in the object of ``data``.
                | Unique ID of the dataspace. This is in format of <Continent>.<DS>.<3 letter code for dataspaces>.<Country>.<dataspace name> for example EU.DS.GND.NL.DVU. Where, continent is 2 letter code, followed by "DS" (stands for dataspace), followed by 3 letter code of common eu dataspaces HLT - Health, INM - Industrial and Manufacturing, AGR - Agriculture, FIN - Finance, MOB - Mobility, GND - Green Deal, ENR - Energy, PUB - Public Administration, SKL - Skills, followed by ISO 3166-1 alpha-2 2 letter Country code and lastly the name/title of the dataspace. Name may not contain spaces or dot "." or other special characters. Maximum length of name can be 15 characters
            ``dataspacedef_url``
                | **String**. Contained in the object of ``data``.
                | URL pointing to the dataspace definition. This is expected to be based on OpenDEI model of building blocks for dataspaces. The machine redable format definition is currently under development. The specifications will be made available once published.
            ``dataspace_website``
                | **String**. Contained in the object of ``data``.
                | Website address of the dataspace, typically dataspace authority. The website details out more information about the datasapce and guides (potential) participants (to become member of) the dataspace.
            ``tags``
                | **String**. Contained in the object of ``data``.
                | Free text field for addting relevant tags that are relevant in the context of datasapce. It useful for searching for specific dataspaces based on tags.
            ``status``
                | **String**. Contained in the object of ``data``.
                | Status of the dataspace. Available values are *new*, *in progress*, *active* and *not active*.
            ``country_reg``
                | **String**. Contained in the object of ``data``.
                | Country in which the dataspace is registered in.
            ``countries_operation``
                | **Array**. Contained in the object of ``data``.
                | Array of country names in which the dataspace operates.
            ``sectors``
                | **Array**. Contained in the object of ``data``.
                | Array of sector names in which the dataspace operates.

    ``certificate_fingerprint``
        | **String**. Contained in the object of ``trusted_list``.
        | SHA256 fingerprint of the certificate.

    ``validity``
        | **String**. Contained in the object of ``trusted_list``.
        | Validity of the certificate. Available values are *valid* or *invalid*.

    ``status``
        | **String**. Contained in the object of ``trusted_list``.
        | Status of the certificate. Available values are *granted*, *withdrawn*, *supervisionceased* and *undersupervision*.

200 OK Example
~~~~~~~~~~~~~~

::

    < Content-Type: application/json

    {
      "dataspace_list_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsIng1YyI6WyJNSUlENkRDQ0F0Q2dBd0lCQWdJSUNwSHRUOUIvTGZVd0RRWUpLb1pJaHZjTkFRRUxCUUF3UERFNk1EZ0dBMVVFQXd3eFZFVlRWQ0JwVTBoQlVrVWdSVlVnU1hOemRXbHVaeUJEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVTQkhOVEFlRncweU16QXlNalF4TmpRek1UTmFGdzB6TXpBeU1qRXhOalF6TVRKYU1IUXhIREFhQmdOVkJBTU1FMmxUU0VGU1JTQlRZMmhsYldVZ1QzZHVaWEl4SERBYUJnTlZCQVVURTBWVkxrVlBVa2t1VGt3d01EQXdNREF3TURBeEZEQVNCZ05WQkFzTUMxUmxjM1FnWVc1a0lGRkJNUk13RVFZRFZRUUtEQXBwVTBoQlVrVlVaWE4wTVFzd0NRWURWUVFHRXdKT1REQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQUp5ems3dnlzdHhKUS9NQ3hTTWF3NHYwdllvOGcya2UxdTZPcElTUUkwTkI4SzBnR1pKN29EbCt6OHJnaHdFYnczNW5TWGxubkhqd1hIekpEcFU0NXlDY2l1N0hSaG1sb2RGNGhlVlFlZUp1MjMwV0oyNXUycWtramM1TG8xd3IvTUpzOW5oY0pyaEVkR3Z5enk2N281aDIvVHpYcitWUkFDTGF6SlhLaEh4SHNaTXNQenJSQ3hKUk9mcytrVzNpSHpiaE15dkFSWERXSnBmQ05aYWhrTDhXcGVIL09PMkxEOTJ1VURNTkZaNWR5bHN1U2kwV285MTh4Wnd5ZmJHZTIxRTZrZEZqTjJ3azZoeGpKeG01YnV0SDJzdDRmeXJLMWxpcDY0K081ZTRRNzh6MWM0blBMVEN0ZHpteUc3NFZuZmNPVFAza0JCZUw0QWlyTWkveWtxY0NBd0VBQWFPQnRUQ0JzakFmQmdOVkhTTUVHREFXZ0JSdHhXV0p5OStSVk5GclBMY0NwUzdOaW1pUUhUQW5CZ05WSFNVRUlEQWVCZ2dyQmdFRkJRY0RBZ1lJS3dZQkJRVUhBd1FHQ0NzR0FRVUZCd01CTURjR0NDc0dBUVVGQndFREJDc3dLVEFJQmdZRUFJNUdBUUV3Q0FZR0JBQ09SZ0VFTUJNR0JnUUFqa1lCQmpBSkJnY0VBSTVHQVFZQ01CMEdBMVVkRGdRV0JCVGU3bUJwVlhWREJjcHBjYkZNYWNKM01SMldGREFPQmdOVkhROEJBZjhFQkFNQ0JzQXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSlByanZSeE40L05ld0ZLMnVWekFNUXJ2WThidGhrVFNGKzg4UHVCZmxXUEMwMXBKb3BMNHAydVRSYWdWMmhGNjFCdmFOakhERVNDbzhBT2lhdW1JMk9vMWRwN2JFdUNKRS95RHppYkJ2TExraTNZMldIQ1RoUVFsT0RsWGRSajhSN3NNaGRjZzNBS04yQWtPbWxkQlJoV0h4aFNvTDVmQ3pLUlFqS0U4MlFUUGo2R2pjcUNUWHcrSTNZSkt2VEIwRjBXa01TSEVFOGxPVkowOUdpQ3VocFZTYUg2bFZuNGN6VkxsTWJvTnAyQXdXTFRIWkk5dll6dTJReHBBVVQyeXNZNW1kVGNlRmRXYzFQQVBFTlpPaFd6UGN0Mmh3aXpqRnJtRFFyRVVNZ01pTjJkNHZKNWxhYzAwTnB1STJjS21WcWZvdmNjUlRrRG02YXdKL1RYSnZVPSIsIk1JSURTRENDQWpDZ0F3SUJBZ0lJU3hSM0ltekcxQmN3RFFZSktvWklodmNOQVFFTEJRQXdKekVsTUNNR0ExVUVBd3djVkVWVFZDQnBVMGhCVWtVZ1JtOTFibVJoZEdsdmJpQmxTVVJCVXpBZUZ3MHhPVEF5TWpJeE1EQTBNekZhRncwek9UQXlNVGN4TURBeU5EbGFNRHd4T2pBNEJnTlZCQU1NTVZSRlUxUWdhVk5JUVZKRklFVlZJRWx6YzNWcGJtY2dRMlZ5ZEdsbWFXTmhkR2x2YmlCQmRYUm9iM0pwZEhrZ1J6VXdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFESEIyQUJRTDd6d21pMXhJa08wYTJxNmpJSmRuM1FBbTBzMWxTZVFldjlGMkYzTTVaOHFpcVFKYXVyTVp5d1pmZE52ZzkrSXFHSE9qRGU2aElodVJ6em9BbzBBYk80TjlPZGYyUkREVTk1Tjd0b0ptQXlDaVlHZ1pmWnQ3QnNLRkllUTZwNkNzZ0tjUlhQaTBmZFhkVlNIcDRiWmZRT1FkY2xNYnRJVGlybkZ0VTA2TlBBaG9ZNjc2WXo5NnhGQUUwem9tNmVNVlBQT0ltMEc4Z2Q0NFhsbmJMMHcwbWNjQ2kyVlVaanZDSUw1OU82MU84dmxWeUxzQnFOTlRDdmY5QzJDTVlhRWF0WFp5ei9sd2dINkpZSHREMHVzWHQvK00wcUtZZTFvZW9MazBaaWNGWlhjazFpUzA5a0ZkZ2dLNUJsTm9kb1dKYURCUnJvNTFXaFkyV25BZ01CQUFHall6QmhNQThHQTFVZEV3RUIvd1FGTUFNQkFmOHdId1lEVlIwakJCZ3dGb0FVbFpNa3lieWhDeks1SE9CRkhLUk8rTUxTUi80d0hRWURWUjBPQkJZRUZHM0ZaWW5MMzVGVTBXczh0d0tsTHMyS2FKQWRNQTRHQTFVZER3RUIvd1FFQXdJQmhqQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFaSDVRanVxK085RnB2NjM3ZzBjRjZuMUlMWUJMejFlTlpqRUIzZG9BZXh2aTVDelN3M29zd0pDU2VkR1czaGgwcUhPVEsyZ0k4M2poMFcyRUFuMmlzRmd3aE1vRzJqZDJZU0ZTa204US8yZU9mYzZNZ0dTQzVzT1RMNzVKN2J5TENvcmRxZC9ONGVhajNFcUtMYVdxN3I3dXN0UDgxUDhFSWx6MEQ4YTdsZmYxRlNvMjNIV1hUV1gyK20ydm9MQUU1bDk3YUdUR1JTMVVieGhQMmpGS1lKOVh6aUtlOU1RSlNaRWxUUThqcWcya1BGa0V4L1hxQVdxbEcxZGwxeXdMSnE1aWVQdksxUjRBWU5JL1liWlFrOXNsajh2K1AvNk03RXRFcnNmMnVJU2dld0xUY1dsMjR4M25HNXhiUVp4clA4bDJqU0dZbU9USW5nS09RU25iZmc9PSIsIk1JSURNekNDQWh1Z0F3SUJBZ0lJQkxVMmNaQVpxTEV3RFFZSktvWklodmNOQVFFTEJRQXdKekVsTUNNR0ExVUVBd3djVkVWVFZDQnBVMGhCVWtVZ1JtOTFibVJoZEdsdmJpQmxTVVJCVXpBZUZ3MHhPVEF5TWpJeE1EQXlORGxhRncwek9UQXlNVGN4TURBeU5EbGFNQ2N4SlRBakJnTlZCQU1NSEZSRlUxUWdhVk5JUVZKRklFWnZkVzVrWVhScGIyNGdaVWxFUVZNd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUNyRFAyRFdYMy9iOHVNYXB6RUJBVFNhNmlaZnZnZ3pJQlVFeGtXRWJHOWUxblZ5L2pRazIwbmZTRk1VbVJUNk5oWWNka1NZTy9XcmtpOVk0RXBDeTF4dlpIcUwrNFk2UzlKTFp3Sjc2MExwWWxlK05hVnU3bWluTVVRY3VvajVuS3pDbHZhemIwMEF4NWdrSlVmUjN2M1g1R1hxUXJrV2F6TXQrazVUTk02VFd1SjMwcU9md3JIeDV2VExtVFVVaWgrQnNHTDNmNUdPczFWVFlJQ05oaVRqTjc0bjJXcXAya1VMV0llKy9YNlJaL2hLc3BhSEdabktEVlR3SSs4Wm1XRmVqdXhBNkRPWDdSc1lMS3ZRTzIxRm1iSUJvU3M5QXp2NTkvUnhXVUpWTU8wV2hEaEtwUWdDR2p3Z1YzMm9mTmRrRmdtZFZ1bHpOUElEMlJOYlRUTEFnTUJBQUdqWXpCaE1BOEdBMVVkRXdFQi93UUZNQU1CQWY4d0h3WURWUjBqQkJnd0ZvQVVsWk1reWJ5aEN6SzVIT0JGSEtSTytNTFNSLzR3SFFZRFZSME9CQllFRkpXVEpNbThvUXN5dVJ6Z1JSeWtUdmpDMGtmK01BNEdBMVVkRHdFQi93UUVBd0lCaGpBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQVFFQWx6YUJWYUZoWm1IOXV4c0xTdjNGa2t4V1Z3QlIxR2hBeHdjSmxWNHgra3FYOHRjaEo0U0RMRXVXUnJGNEROdHZTUjNyNjlLejhlWUk1WHVXMWVHMTJZakdHVmxZaWpkeHJHMUFOekduMnZkbzl2TDdkRUZVRU1LMUFLeFJzdGJUZEU3eXd6SVYvQzYxdzhKcnh3THR0OU9qZFVFVVBIdUdUanV2NW5GQlBkRnpPY3Z1K0RUTWw3M0NKUDJ6ZVpVRmd1ajU1TXNYWTQ1TXJYcmJndCtMSnFVdTRwa0IyYkx1OUZiZVJMV1pKdWtuWVNyVzRmeVFCWjJpK01zR2RpQktRY2YzZkxYanBjaDQ4L3A3U2lUazR1ZmxvQmFxVENsdC9FdFdYRFNtRmN2NFFqQmsxbVVQdTl2eGlrY0hEa0F2SnJPWEdnMGIrM2VJNGE3T1RmQWIxZz09Il19.eyJhdWQiOiJFVS5FT1JJLk5MMDAwMDAwMDAzIiwiZGF0YXNwYWNlX2luZm8iOnsidG90YWxfY291bnQiOjcsInBhZ2VDb3VudCI6MSwiY291bnQiOjcsImRhdGEiOlt7ImRhdGFzcGFjZV90aXRsZSI6IkRMRFNfTG9naXN0aWNzX0RhdGFTcGFjZSIsImRhdGFzcGFjZV9pZCI6IkVVLkRTLk5MLkRMRFNfTG9naXN0aWNzIiwiZGF0YXNwYWNlZGVmX3VybCI6IiIsImRhdGFzcGFjZV93ZWJzaXRlIjoiIiwidGFncyI6IiIsInN0YXR1cyI6IkFjdGl2ZSIsImNvdW50cnlfcmVnIjoiIE5ldGhlcmxhbmRzIiwiY291bnRyaWVzX29wZXJhdGlvbiI6WyIgTmV0aGVybGFuZHMiXSwic2VjdG9ycyI6W119LHsiZGF0YXNwYWNlX3RpdGxlIjoiVGVzdERTUCIsImRhdGFzcGFjZV9pZCI6IkVVLkRTUC5OTFRFU1REU1AiLCJkYXRhc3BhY2VkZWZfdXJsIjoiIiwiZGF0YXNwYWNlX3dlYnNpdGUiOiIiLCJ0YWdzIjoiIiwic3RhdHVzIjoiSW5Qcm9ncmVzcyIsImNvdW50cnlfcmVnIjoiIiwiY291bnRyaWVzX29wZXJhdGlvbiI6W10sInNlY3RvcnMiOltdfSx7ImRhdGFzcGFjZV90aXRsZSI6IkNvbnRha3REUzEiLCJkYXRhc3BhY2VfaWQiOiJDb250YWt0RFMxIiwiZGF0YXNwYWNlZGVmX3VybCI6IiIsImRhdGFzcGFjZV93ZWJzaXRlIjoid3d3LmNvbnRha3QubmwiLCJ0YWdzIjoiI3Rlc3QiLCJzdGF0dXMiOiJJblByb2dyZXNzIiwiY291bnRyeV9yZWciOiIgTmV0aGVybGFuZHMiLCJjb3VudHJpZXNfb3BlcmF0aW9uIjpbIiBOZXRoZXJsYW5kcyJdLCJzZWN0b3JzIjpbIkluZm9ybWF0aW9uIFRlY2hub2xvZ3kiXX0seyJkYXRhc3BhY2VfdGl0bGUiOiJOTC5BSVJGUkVJR0hUIiwiZGF0YXNwYWNlX2lkIjoiTkwuQUlSRlJFSUdIVCIsImRhdGFzcGFjZWRlZl91cmwiOiIiLCJkYXRhc3BhY2Vfd2Vic2l0ZSI6Imh0dHBzOi8vd3d3LmNhcmdvbmF1dC5ubCIsInRhZ3MiOiIjYWlyICIsInN0YXR1cyI6IkluUHJvZ3Jlc3MiLCJjb3VudHJ5X3JlZyI6IiIsImNvdW50cmllc19vcGVyYXRpb24iOlsiIE5ldGhlcmxhbmRzIl0sInNlY3RvcnMiOlsiSW5mb3JtYXRpb24gVGVjaG5vbG9neSJdfSx7ImRhdGFzcGFjZV90aXRsZSI6IlVuaVNhbGVudG9EUyIsImRhdGFzcGFjZV9pZCI6IkVVLkRTLklUVU5JU0FMRFMiLCJkYXRhc3BhY2VkZWZfdXJsIjoiIiwiZGF0YXNwYWNlX3dlYnNpdGUiOiIiLCJ0YWdzIjoiIiwic3RhdHVzIjoiTmV3IiwiY291bnRyeV9yZWciOiJJdGFseSIsImNvdW50cmllc19vcGVyYXRpb24iOltdLCJzZWN0b3JzIjpbXX0seyJkYXRhc3BhY2VfdGl0bGUiOiJpU0hBUkUgVGVzdCBTcGFjZSIsImRhdGFzcGFjZV9pZCI6IkVVLmlTSEFSRSIsImRhdGFzcGFjZWRlZl91cmwiOiIiLCJkYXRhc3BhY2Vfd2Vic2l0ZSI6IiIsInRhZ3MiOiIiLCJzdGF0dXMiOiJBY3RpdmUiLCJjb3VudHJ5X3JlZyI6IiBOZXRoZXJsYW5kcyIsImNvdW50cmllc19vcGVyYXRpb24iOlsiIE5ldGhlcmxhbmRzIl0sInNlY3RvcnMiOlsiSW5mb3JtYXRpb24gVGVjaG5vbG9neSJdfSx7ImRhdGFzcGFjZV90aXRsZSI6IlRFU1QgRFMiLCJkYXRhc3BhY2VfaWQiOiJFVS5URVNULkVVLjEwMDEiLCJkYXRhc3BhY2VkZWZfdXJsIjoiIiwiZGF0YXNwYWNlX3dlYnNpdGUiOiIiLCJ0YWdzIjoiIiwic3RhdHVzIjoiTmV3IiwiY291bnRyeV9yZWciOiIiLCJjb3VudHJpZXNfb3BlcmF0aW9uIjpbXSwic2VjdG9ycyI6W119XX0sImV4cCI6MTY5MTA3ODk2MywiaWF0IjoxNjkxMDc4OTMzLCJpc3MiOiJFVS5FT1JJLk5MMDAwMDAwMDAwIiwianRpIjoiZGMzMjkwNzI2ZjhhNDMyYzhjMjQ4ZWJkMjAzZTdhNDEiLCJuYmYiOjE2OTEwNzg5MzMsInN1YiI6IkVVLkVPUkkuTkwwMDAwMDAwMDAifQ.O8yVlkMY-RCwHyIitS6ODIFC5F-tsTA2ovbOhZGyei_1OVpNe60cDSKrjKXS0YWuudEvx-BZKhfEhNuF2U4HSX8IanaA0dPhrg6o3XldsPVUJ5rIBnyKLEI3XotqZnSXlCt4gJ0xx9isJeQ3LOQpp2TP73gAyIg-KAIrPMd2hx1rPLk33gOT7FO_lZV3Ow8kvaCwQqM-4nX0QfgkJyt3BLFZY-tniMARkByeQdb1JeBlL4_XUDxkp0CmhADo-BbUA6fAz37VA_mdhZYqHimvdi4MiLjt_Sxik1lZouKhHS7L4gLE2FE4LE4KEqdDusMs-T3lklNkIrOKHfSFUScMHw"
    }

Decoded JWT Payload
^^^^^^^^^^^^^^^^^^^

.. code-block:: json

    {
      "aud": "EU.EORI.NL000000003",
      "dataspace_info": {
        "total_count": 7,
        "pageCount": 1,
        "count": 7,
        "data": [
          {
            "dataspace_title": "DLDS_Logistics_DataSpace",
            "dataspace_id": "EU.DS.NL.DLDS_Logistics",
            "dataspacedef_url": "",
            "dataspace_website": "",
            "tags": "",
            "status": "Active",
            "country_reg": " Netherlands",
            "countries_operation": [
              " Netherlands"
            ],
            "sectors": []
          },
          {
            "dataspace_title": "TestDSP",
            "dataspace_id": "EU.DSP.NLTESTDSP",
            "dataspacedef_url": "",
            "dataspace_website": "",
            "tags": "",
            "status": "InProgress",
            "country_reg": "",
            "countries_operation": [],
            "sectors": []
          },
          {
            "dataspace_title": "ContaktDS1",
            "dataspace_id": "ContaktDS1",
            "dataspacedef_url": "",
            "dataspace_website": "www.contakt.nl",
            "tags": "#test",
            "status": "InProgress",
            "country_reg": " Netherlands",
            "countries_operation": [
              " Netherlands"
            ],
            "sectors": [
              "Information Technology"
            ]
          },
          {
            "dataspace_title": "NL.AIRFREIGHT",
            "dataspace_id": "NL.AIRFREIGHT",
            "dataspacedef_url": "",
            "dataspace_website": "https://www.cargonaut.nl",
            "tags": "#air ",
            "status": "InProgress",
            "country_reg": "",
            "countries_operation": [
              " Netherlands"
            ],
            "sectors": [
              "Information Technology"
            ]
          },
          {
            "dataspace_title": "UniSalentoDS",
            "dataspace_id": "EU.DS.ITUNISALDS",
            "dataspacedef_url": "",
            "dataspace_website": "",
            "tags": "",
            "status": "New",
            "country_reg": "Italy",
            "countries_operation": [],
            "sectors": []
          },
          {
            "dataspace_title": "iSHARE Test Space",
            "dataspace_id": "EU.iSHARE",
            "dataspacedef_url": "",
            "dataspace_website": "",
            "tags": "",
            "status": "Active",
            "country_reg": " Netherlands",
            "countries_operation": [
              " Netherlands"
            ],
            "sectors": [
              "Information Technology"
            ]
          },
          {
            "dataspace_title": "TEST DS",
            "dataspace_id": "EU.TEST.EU.1001",
            "dataspacedef_url": "",
            "dataspace_website": "",
            "tags": "",
            "status": "New",
            "country_reg": "",
            "countries_operation": [],
            "sectors": []
          }
        ]
      },
      "exp": 1691078963,
      "iat": 1691078933,
      "iss": "EU.EORI.NL000000000",
      "jti": "dc3290726f8a432c8c248ebd203e7a41",
      "nbf": 1691078933,
      "sub": "EU.EORI.NL000000000"
    }
