# API Retrieve Gift Redemption Transaction Details

This API allows partners to query details about a specific gift redemption transaction using the **transaction code** and **member code**. Through this API, you can view detailed information about the gift, the transaction status, and related data.

---

## Table of Contents

1. [API Details](#api-details)
    - [Headers](#headers)
    - [Request](#request)
2. [Request Example](#request)
3. [Response Example](#response)
    - [Successful Case](#success)
    - [Failure Case](#failure)
4. [Notes](#note)
    - [Valid Transaction Code](#note-1)
    - [Provide Correct and Complete Headers](#note-2)
    - [Transaction Status Breakdown](#note-3)

---

## 1. API Details <a id="api-details"></a>

-   **Endpoint**: `/affina/get-redeem-tx-detail`
-   **Method**: `GET`
-   **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| **Header Name** | **Type** | **Required** | **Description**                            |
| --------------- | -------- | ------------ | ------------------------------------------ |
| `X-API-Key`     | String   | Yes          | The API key provided by LynkiD.            |
| `X-Partner-ID`  | String   | Yes          | The partner identifier provided by LynkiD. |

### 1.2. Query Parameters <a id="query-params"></a>

| **Parameter Name**    | **Type** | **Required** | **Description**                                                    | **Example**     |
| --------------------- | -------- | ------------ | ------------------------------------------------------------------ | --------------- |
| `partnerMemberCode`   | String   | Yes          | The member code from the partner system.                           | `"PARTNER001"`  |
| `giftTransactionCode` | String   | Yes          | The transaction code of the gift, linked to the partnerMemberCode. | `"TX_CODE_001"` |

---

## 2. Request Example <a id="request"></a>

```http
[rootURL]/affina/get-redeem-tx-detail?partnerMemberCode=PARTNER001&giftTransactionCode=TX_CODE_001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Response Example <a id="response"></a>

### 3.1. Successful Case <a id="success"></a>

```json
{
    "giftTransaction": {
        "code": "TX_CODE",
        "buyerCode": "LinkIDMemberCode",
        "ownerCode": "LinkIDMemberCode",
        "transferTime": null,
        "introduce": "",
        "giftCode": "GIFTCODE",
        "giftName": "GiftName",
        "quantity": 1,
        "coin": 1000,
        "date": "2024-05-14T11:24:05.7101773+07:00",
        "status": "Delivered",
        "giftId": 111,
        "totalCoin": 1000,
        "description": null,
        "transactionCode": "TXCode",
        "qrCode": "Http://url-img",
        "codeDisplay": "QRCode",
        "id": null,
        "linkShippingInfo": "Address",
        "serialNo": "Seri"
    },
    "imageLinks": ["http://linki-anhr/", "http://linki-anhr/url2"],
    "vendorInfo": {
        "type": null,
        "image": "http://link-anh",
        "hotLine": null,
        "id": 12,
        "vendorName": "VendorName"
    },
    "code": "00",
    "message": "Success"
}
```

-   Description of Response Fields

    | Field Name      | Type   | Description                                      | Example   |
    | --------------- | ------ | ------------------------------------------------ | --------- |
    | giftTransaction | Object | Detailed information about the gift transaction. |           |
    | code            | String | Response status code. "00" indicates success.    | `00`      |
    | message         | String | Detailed message about the transaction status.   | `Success` |
    | imageLinks      | Array  | List of image links related to the gift.         |           |
    | vendorInfo      | Object | Information about the gift vendor.               |           |

-   Fields inside `giftTransaction`:

    | **Field Name**   | **Type** | **Description**                                          | **Example**          |
    | ---------------- | -------- | -------------------------------------------------------- | -------------------- |
    | code             | String   | Transaction code of the gift.                            | `"TX_CODE"`          |
    | buyerCode        | String   | Member code of the buyer.                                | `"LinkIDMemberCode"` |
    | ownerCode        | String   | Member code of the gift owner.                           | `"LinkIDMemberCode"` |
    | transferTime     | String   | Transfer time (if applicable).                           | `null`               |
    | giftCode         | String   | Code of the redeemed gift.                               | `"GIFTCODE"`         |
    | giftName         | String   | Name of the redeemed gift.                               | `"GiftName"`         |
    | quantity         | Integer  | Quantity of the redeemed gift.                           | `1`                  |
    | coin             | Integer  | Points used for the redemption.                          | `1000`               |
    | status           | String   | Transaction status (`Delivered`, `Pending`, `Rejected`). | `"Delivered"`        |
    | giftId           | Integer  | Internal ID of the redeemed gift in the system.          | `111`                |
    | totalCoin        | Integer  | Total points used for the redemption.                    | `1000`               |
    | description      | String   | Additional details about the gift (if any).              | `null`               |
    | transactionCode  | String   | Unique transaction code for the gift.                    | `"TXCode"`           |
    | qrCode           | String   | Link to the QR code for the redeemed gift.               | `"Http://url-img"`   |
    | codeDisplay      | String   | QR code or barcode display format.                       | `"QRCode"`           |
    | linkShippingInfo | String   | Shipping address information (if applicable).            | `"Address"`          |
    | serialNo         | String   | Serial number of the redeemed gift.                      | `"Seri"`             |

-   Fields inside `vendorInfo`:

    | **Field Name** | **Type** | **Description**                          | **Example**         |
    | -------------- | -------- | ---------------------------------------- | ------------------- |
    | type           | String   | Type of vendor (if applicable).          | `null`              |
    | image          | String   | Link to the vendor's logo or image.      | `"http://link-anh"` |
    | hotLine        | String   | Vendor's hotline (if applicable).        | `null`              |
    | id             | Integer  | Internal ID of the vendor in the system. | `12`                |
    | vendorName     | String   | Name of the vendor.                      | `"VendorName"`      |

### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "1026",
    "message": "Transaction not found"
}
```

-   Explanation of Error Codes:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Successful, returns list of gift exchange transactions. |

## 4. Notes <a id="note"></a>

### 4.1 Valid Transaction Code <a id="note-1"></a>

-   Ensure giftTransactionCode belongs to the partnerMemberCode and has been processed in the system

### 4.2 Provide Correct and Complete Headers <a id="note-2"></a>

-   `X-API-Key` and `X-Partner-ID` are mandatory in every request.

### 4.3 Transaction Status Breakdown <a id="note-3"></a>

-   Check the status field in giftTransaction for the current state of the transaction (e.g., Delivered, Pending).
