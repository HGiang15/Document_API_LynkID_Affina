# LynkiD Points Inquiry API

This API allows partners to query the point balance of a member from the LynkiD system.  
When calling the API, you need to provide the **partner member code** (partnerMemberCode) to retrieve the balance information and LynkiD wallet.

---

## Table of Contents

1. [API Details](#api-details)
    - [Headers](#headers)
    - [Query Params](#query-params)
2. [Sample Request](#request)
3. [Sample Response](#response)
    - [Success Case](#success)
    - [Failure Case](#failure)
4. [Notes](#note)
    - [Passing Correct Headers](#note-1)
    - [Check Response](#note-2)
    - [Data Format](#note-3)
    - [Security](#note-4)

## 1. API Details <a id="api-details"></a>

- **Endpoint**: `/affina/view-point`
- **Method**: `GET`
- **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| Header Name     | Type   | Required | Description                                   |
| --------------- | ------ | -------- | --------------------------------------------- |
| `X-API-Key`     | String | Yes      | API key identifier provided by LynkiD.        |
| `X-Partner-ID`  | String | Yes      | Partner identifier provided by LynkiD.        |

### 1.2. Query Params <a id="query-params"></a>

#### Request Query String

| Parameter Name      | Type   | Required | Description                                 | Example      |
| ------------------- | ------ | -------- | ------------------------------------------- | ------------ |
| `partnerMemberCode` | String | Yes      | The partner's member identifier.            | `AFCODE0001` |

---

## 2. Sample Request <a id="request"></a>

```http
[rootURL]/affina/view-point?partnerMemberCode=AFCODE0001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Sample Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

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

-   Explanation of Response Fields
    | Field Name | Type | Description | Example |
    | ------------------- | ------ |--------------------------------------- | ------------ |
    | `code` | String | Indicate the status of the response. | `00` |
    | `message` | String | Indicate status details. | `Success` |
    | `partnerMemberCode` | String | The partner's member identifier. | `P_MemberCode_01` |
    | `lynkiDWallet` | String | The wallet address of the customer on LynkiD. | `f8e1facb995f0e2cf9eaebab95ce62f273fc07` |
    | `balance` | Decimal | Current balance of the customer on LynkiD. | `1000000` |
    | `expiringBalance` | Decimal | Nullable. If data exists, it represents the expiring balance of the member. | `12000` |

### 3.2. Failure Case <a id="failure"></a>
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

-   Explanation of Error Codes:
    | Tên Trường | Loại |
    | ---------- | ------ |
    | `00` | Success |
    | `04` | The member is not connected with a LynkiD account. |

## 4. Notes <a id="note"></a>

### 4.1 Passing Correct and Complete Headers <a id="note-1"></a>

-   X-API-Key and X-Partner-ID are required for every request.

### 4.2 Check Response <a id="note-2"></a>

-   Check the code and message fields in the response to determine the status.

### 4.3 Data Format <a id="note-3"></a>

-   Ensure that the request uses the JSON format when necessary (in other APIs).

### 4.4 Security <a id="note-4"></a>

-   The X-API-Key and X-Partner-ID pair is unique for each partner and should not be shared publicly.
