# Getting Started with LynkiD - Affina Integration API

This document will guide you on how to get started using the integration APIs between the **LynkiD** system and **Affina**. It includes setting up the environment, making basic API calls, and important things to note.

---

## Table of Contents

1. [Basic Setup Steps](#set-up)
   - [Data Format](#format)
   - [Environment Configuration](#environment)
   - [Required Headers](#headers)
2. [Testing Your First API](#test-api)
3. [Recommended Tools](#tools)
    - [Testing Tools](#tool)
    - [Testing Tips](#check)
4. [Notes](#note)
5. [What to Do Next](#next-step)

## 1. Basic Setup Steps <a id="set-up"></a>

### 1.1. Data Format <a id="format"></a>

- All **input** and **output** for the API use the **JSON** format.
- Ensure to check the request and response formats before sending or processing them.

### 1.2. Environment Configuration <a id="environment"></a>

Use the following **Base URLs** for different environments:

> **UAT (Testing):** `[UAT_BASE_URL]`

> **Production (Deployment):** `[PROD_BASE_URL]`

### 1.3. Required Headers <a id="headers"></a>

Each request needs to include the following headers:

> **`X-API-Key`**: The API key identifier (provided by LynkiD).

> **`X-Partner-ID`**: The partner identifier (provided by LynkiD).

Example:

```http
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 2. Testing your first API <a id="test-api"></a>

### Sample API: View LynkiD Points

-   Endpoint: /affina/view-point
-   Method: `GET`
-   Query Params:

    -   partnerMemberCode (bắt buộc): Partner member identifier.

-   Example Request

```
GET /affina/view-point?partnerMemberCode=AFCODE0001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

-   Example Response (Success)

```json
{
    "partnerMemberCode": "P_MemberCode_01",
    "lynkiDWallet": "f8e1facb995f0e2cf9eaebab95ce62f273fc07",
    "balance": 1000000,
    "expiringBalance": 12000,
    "code": "00",
    "message": "Successful",
    "messageDetail": null
}
```

-   Example Response (Failure)

```json
{
    "partnerMemberCode": "P_MemberCode_01",
    "lynkiDWallet": null,
    "balance": 0,
    "expiringBalance": null,
    "code": "04",
    "message": "Partner Member Is Not Connected With A LynkiD Account",
    "messageDetail": null
}
```

## 3. Recommended Tools <a id="tools"></a>

### 3.1. Testing Tools <a id="tool"></a>

-   You can use the following tools to call and test the API:
    -   Postman: A user-friendly interface for API testing.
    -   Curl: A quick testing tool via terminal command.
    -   Insomnia: A lightweight alternative to Postman.

### 3.2. Testing Tips <a id="check"></a>

-   Ensure all headers and query params are provided correctly.
-   Match the error codes in the response (code, message) to identify the issue if the request fails

## 4. Notes <a id="note"></a>

    - The API uses security mechanisms based on trusted API Keys and Whitelist IPs.
    - The pair X-API-Key and X-Partner-ID is unique for each partner and should not be shared publicly.
    - Ensure to check the JSON format of both the request and response to avoid formatting errors.

## 5. What to Do Next? <a id="next-step"></a>

-   Read more: Explore the details of the APIs below to understand each API:
    -   `api-view-point`: View points.
    -   `api-category`: Manage gift categories.
    -   `api-redeem`: Redeem gifts.
    -   `api-get-redeem-transaction`: Gift redemption history.
-   Test more: Integrate other APIs into your system based on the detailed guides.
