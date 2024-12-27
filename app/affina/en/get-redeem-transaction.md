# API Check Gift Redemption History

This API allows partners to query the gift redemption history of members in the LynkiD system. Partners can filter results by date, transaction status, eGift status, and paginate results.

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
    - [Pagination](#note-1)
    - [Handling Transaction Status](#note-2)
    - [Filter by eGift Status](#note-3)
5. [Next Steps](#next-step)

---

## 1. API Details <a id="api-details"></a>

-   **Endpoint**: `/affina/get-redeem-transaction`
-   **Method**: `GET`
-   **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| **Header Name** | **Type** | **Required** | **Description**                        |
| --------------- | -------- | ------------ | -------------------------------------- |
| `X-API-Key`     | String   | Yes          | API key identifier provided by LynkiD. |
| `X-Partner-ID`  | String   | Yes          | Partner identifier provided by LynkiD. |

### 1.2. Query Params <a id="query-params"></a>

| **Field Name**      | **Type** | **Required** | **Description**                                                   | **Example**             |
| ------------------- | -------- | ------------ | ----------------------------------------------------------------- | ----------------------- |
| `partnerMemberCode` | String   | Yes          | Member code on the partner's side.                                | `"PARTNER001"`          |
| `fromDate`          | DateTime | No           | Filter transactions from this date. Defaults to the last 30 days. | `"2024-05-01T00:00:00"` |
| `toDate`            | DateTime | No           | Filter transactions until this date.                              | `"2024-06-01T00:00:00"` |
| `statusFilter`      | String   | No           | Transaction status (`Delivered`, `Rejected`, etc.).               | `"Delivered"`           |
| `eGiftStatusFilter` | String   | No           | eGift status (`Available`, `Redeemed`, `Used`, `Expired`).        | `"Redeemed"`            |
| `skipCount`         | Integer  | Yes          | Pagination offset. Defaults to `0`.                               | `0`                     |
| `maxResultCount`    | Integer  | Yes          | Number of records per page. Defaults to `10`.                     | `10`                    |

---

## 2. Sample Request <a id="request"></a>

```http
[rootURL]/affina/get-redeem-transaction?partnerMemberCode=PARTNER001&fromDate=2024-05-01T00:00:00&toDate=2024-06-01T00:00:00&statusFilter=Delivered&eGiftStatusFilter=Redeemed&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Sample Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

```json
{
    "count": 1,
    "items": [
        {
            "giftTransaction": {
                "code": "TX_CODE",
                "buyerCode": "LinkIDMemberCode",
                "ownerCode": "LinkIDMemberCode",
                "transferTime": null,
                "giftCode": "GIFTCODE",
                "giftName": "GiftName",
                "quantity": 1,
                "coin": 1000,
                "date": "2024-05-14T11:22:48.5075146+07:00",
                "status": "Delivered",
                "giftId": 111,
                "totalCoin": 1000,
                "description": null,
                "transactionCode": "TXCode",
                "qrCode": "http://url-img",
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
            }
        }
    ],
    "code": "00",
    "message": "Success"
}
```

-   Explanation of Response Fields:

    | **Field Name** | **Type** | **Description**                             | **Example**        |
    | -------------- | -------- | ------------------------------------------- | ------------------ |
    | `count`        | int      | Total number of transactions returned.      | `1`                |
    | `items`        | Array    | List of gift redemption transactions.       | See details below. |
    | `code`         | String   | Response status code. `"00"` means success. | `"00"`             |
    | `message`      | String   | Detailed status message.                    | `"Success"`        |

-   Fields inside `giftTransaction`:

    | **Field Name**        | **Type**   | **Description**                                        | **Example**            |
    |------------------------|------------|------------------------------------------------------|------------------------|
    | `code` | String | Transaction code. | `"TX_CODE"` |
    | `buyerCode` | String | Buyer member code. | `"LinkIDMemberCode"` |
    | `ownerCode` | String | Owner member code. | `"LinkIDMemberCode"` |
    | `transferTime` | String | Transfer time (if applicable). | `null` |
    | `giftCode` | String | Redeemed gift code. | `"GIFTCODE"` |
    | `giftName` | String | Name of the redeemed gift. | `"GiftName"` |
    | `quantity` | int | Quantity of the gift redeemed. | `1` |
    | `coin` | int | Points used for redemption. | `1000` |
    | `status` | String | Transaction status (Delivered, Rejected, etc.). | `"Delivered"` |
    | `giftId` | int | Internal ID of the redeemed gift. | `111` |
    | `totalCoin` | int | Total points used for the transaction. | `1000` |
    | `description` | String | Description of the transaction (if available). | `null` |
    | `transactionCode` | String | Unique transaction code for the gift. | `"TXCode"` |
    | `qrCode` | String | QR code link for the gift. | `"http://url-img"` |
    | `linkShippingInfo` | String | Shipping address information (if applicable). | `"Address"` |
    | `serialNo` | String | Serial number of the redeemed gift. | `"Seri"` |

### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "1025",
    "message": "Out of stock"
}
```

-   Error Code Explanations:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Success: Transactions retrieved successfully. |
    | `1025` | The requested gift is out of stock. |
    | `1026` | Invalid search criteria (e.g., incorrect member code). |
    | `1027` | No transactions found within the specified date range.|

## 4. Notes <a id="note"></a>

### 4.1 Pagination <a id="note-1"></a>

-   Use skipCount and maxResultCount for paginated results when there are many records.

### 4.2 Handling Transaction Status <a id="note-2"></a>

-   Check the status field to determine whether a transaction was successful.

### 4.3 Filter by eGift Status <a id="note-3"></a>

-   Use eGiftStatusFilter to filter by specific eGift statuses such as Redeemed, Used, or Expired.

## 5. Next Steps <a id="next-step"></a>

-   View Transaction Details:
    -   Use the `get-redeem-tx-detail` API for detailed transaction information.
-   Complete Redemption:
    -   Use the `verify-otp-redeem-gift` API to finalize gift redemptions.
