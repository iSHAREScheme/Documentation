.. _refVideos:

Videos
======

This section contains various video demos of iSHARE in action. Below some videos timestamps are included. These are abbrevations for the test parties:

* **AR** - Authorization Registry
* **SO** - Scheme Owner (since iSHARE 2.0 this role is performed by the iSHARE Satellite - wherever SO is mentioned, this must be interpreted as iSHARE Satellite)
* **W13** - Warehouse 13 (Service Provider)

.. _refGetAccessTokenDemo:

Getting an access token
-----------------------
.. raw:: html

    <iframe frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/bH6rjBm3wUA"  width="100%" height="350"></iframe>

============= ====================================
Time          Topic
============= ====================================
01:06 - 04:50 How certificates work in iSHARE
04:50 - 07:24 How JSON Web Tokens work in iSHARE
07:25 - 10:44 How client_assertions work in iSHARE
10:45 - 12:42 How access tokens work in iSHARE
============= ====================================

Slides available for download :download:`here <resources/190425A_Getting_an_access_token.pdf>`.

Walkthrough of Postman (demo 1a)
--------------------------------
.. raw:: html

    <iframe frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/R6hi6zTt3Jw"  width="100%" height="350"></iframe>

===== =============== ===== ====================
Time  API Call        Time  API Call 
===== =============== ===== ====================
07:06 W13 POST /token 10:04 SO GET /parties
07:30 SO POST /token  10:24 AR POST /token
07:40 SO GET /parties 10:38 SO POST /token
09:45 W13 /service    10:43 SO GET /parties
10:00 SO POST /token  11:00 AR POST /delegation
===== =============== ===== ====================

Walkthrough of Postman (demo 1b)
--------------------------------
.. raw:: html

    <iframe frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/lrEque5WWbY"  width="100%" height="350"></iframe>

===== =================== ===== ====================
Time  API Call            Time  API Call 
===== =================== ===== ====================
07:57 SO POST /token      13:48 W13 POST /token
08:15 SO GET /parties     13:54 SO POST /token
10:06 AR POST /token      14:05 SO GET /parties
10:18 SO POST /token      15:32 W13 /service
10:25 SO GET /parties     16:35 SO GET /parties
10:44 AR POST /delegation
===== =================== ===== ====================

.. _refARVideo:

Authorization Registry
----------------------
.. raw:: html

    <iframe frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/uiizp9OXCJg"  width="100%" height="350"></iframe>

ICT & Logistics 2017 (in Dutch)
-------------------------------
.. raw:: html

    <iframe frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/Wg0KJCS_D8Q"  width="100%" height="350"></iframe>