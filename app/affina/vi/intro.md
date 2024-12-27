# LynkiD - Affina Integration API Documentation

## Giới thiệu

This document provides detailed information about the APIs used to integrate the **LynkiD** system with **Affina**.  
The APIs allow partners to perform the following functions:

- **View Points**: Retrieve point information from LynkiD.
- **Category and Gift Management**: Includes category lists and gift information.
- **Redeem Gifts**: Process gift redemption and verify OTP.
- **Gift Redemption History Management**: Track and check completed transactions.
- **System Connection with LynkiD**: Create and verify the connection between Affina and LynkiD.

---

## Table of Contents

1. **Overview**:
    - Data format (JSON).
    - Base URLs for UAT and Production.
    - Required headers when calling the API.

2. **Changelog**:
    - List of changes in the document through versions.

3. **API Details**:
    - APIs grouped by function such as View Points, Category Management, Gift Redemption, etc.

4. **Request/Response Samples**:
    - JSON examples for each API, making it easier to understand and test.

5. **Error Code Table**:
    - List of error codes returned by the API with detailed meanings.

---

## System Requirements

- **Data Format**:
    - All input and output for the API will follow the general format of **JSON**, unless otherwise specified.
- **Base URLs**:
    - UAT base URL: _(not updated yet)_
    - Prod base URL: _(not updated yet)_
- **Required Headers**:
    - `X-API-Key`: API identifier key provided by LynkiD.
    - `X-Partner-ID`: Partner identifier provided by LynkiD.
- **Security**:
    - The API uses **trusted API Key** and **Whitelist IP**, without individual AccessTokens for each member.
    - In the LynkiD system, the pair `X-Partner-ID` and `X-API-Key` is unique.

---

## Base URLs

Different URLs are used for testing and production environments:

- **UAT (Testing)**: `[UAT_BASE_URL]`
- **Production (Deployment)**: `[PROD_BASE_URL]`

---

## Sample Request

Here is an example of a request when calling the "view points" API:

```http
GET /affina/view-point?partnerMemberCode=AFCODE0001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## Description

-   Endpoint: `/affina/view-point`
-   Method: `GET`
-   Query Params:
    -   partnerMemberCode (required).
-   Headers:
    -   `[X-API-Key]`: API identifier key.
    -   `[X-Partner-ID]`: Partner identifier.
