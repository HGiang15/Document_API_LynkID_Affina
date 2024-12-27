# API View Gift Details

This API allows partners to retrieve detailed information about a gift based on the **Gift ID**. The returned information includes the gift's name, description, required points, status, and related images.

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
    - [Providing Correct Headers](#note-1)
    - [Identifying the Correct Gift ID](#note-2)
    - [Check Error Codes](#note-3)
5. [Next Steps](#next-step)

## 1. API Details <a id="api-details"></a>

-   **Endpoint**: `/affina/get-gift-detail`
-   **Method**: `GET`
-   **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| Header Name    | Type   | Required | Description                            |
| -------------- | ------ | -------- | -------------------------------------- |
| `X-API-Key`    | String | Yes      | API key identifier provided by LynkiD. |
| `X-Partner-ID` | String | Yes      | Partner identifier provided by LynkiD. |

### 1.2. Query Params <a id="query-params"></a>

#### Request Query String

| Parameter Name | Type | Required | Description                              | Example |
| -------------- | ---- | -------- | ---------------------------------------- | ------- |
| `giftId`       | int  | Yes      | Gift ID obtained from the gift list API. | `40285` |

---

## 2. Sample Request <a id="request"></a>

### Request

```http
[rootURL]/affina/get-gift-detail?giftId=40285 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Sample Response <a id="response"></a>

### Success Case <a id="success"></a>

```json
{
    "giftDetail": {
        "id": 35975,
        "code": "GiftInfor_20230302093022744_4534",
        "name": "GotIt Multi 15.000",
        "description": "<p>Product multi - Usable across all GOTIT systems</p>\r\n<p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 16px; font-weight: bold\">**Conditions of Use: </p><p>- The electronic gift voucher is provided by Got It.</p>\r\n\r\n<p>- A single invoice can use multiple gift vouchers, with each voucher being valid for one-time use as per the specified terms.</p>",
        "requiredCoin": 15000,
        "categoryCode": "4fa36bf4-58a9-4c08-8226-f0c355529bdb",
        "inStock": 999986,
        "isEgift": true,
        "vendorHotline": null,
        "vendor": "GotIt",
        "vendorImage": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/4672fca351761459c11a22bb695982d8.png",
        "vendorDescription": "GotIt",
        "brandName": null,
        "brandLinkLogo": null,
        "brandAddress": null,
        "brandDescription": null,
        "imageLinks": [
            {
                "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/169be3b937f253cb41d56c1874bcdd19.png",
                "fullLink": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/169be3b937f253cb41d56c1874bcdd19.png"
            }
        ]
    },
    "code": "00",
    "message": null
}
```

-   Explanation of Response Fields:

| **Field Name**            | **Type** | **Description**                                                          | **Example**                                                                                              |
| ------------------------- | -------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- |
| `code`                    | String   | Indicates the status of the response.                                    | `00`                                                                                                     |
| `message`                 | String   | Indicates status details.                                                | `Success`                                                                                                |
| `giftDetail.name`         | String   | Name of the gift.                                                        | `GotIt Multi 15.000`                                                                                     |
| `giftDetail.description`  | String   | Detailed description of the gift.                                        | `<p>Product multi - Usable across all GOTIT systems</p>`                                                 |
| `giftDetail.requiredCoin` | int      | Number of points required to redeem the gift.                            | `15000`                                                                                                  |
| `giftDetail.categoryCode` | String   | Code of the category to which the gift belongs.                          | `4fa36bf4-58a9-4c08-8226-f0c355529bdb`                                                                   |
| `giftDetail.inStock`      | int      | Quantity of the gift available in stock.                                 | `999986`                                                                                                 |
| `giftDetail.isEgift`      | Boolean  | Indicates if the gift is an eGift (`true`) or a physical gift (`false`). | `true`                                                                                                   |
| `giftDetail.vendor`       | String   | Name of the gift's vendor.                                               | `GotIt`                                                                                                  |
| `giftDetail.vendorImage`  | String   | URL to the vendor's logo or image.                                       | `https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/4672fca351761459c11a22bb695982d8.png` |
| `giftDetail.imageLinks`   | Array    | A list of image links related to the gift.                               | See example above                                                                                        |


### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "04",
    "message": "Gift not found.",
    "giftDetail": null
}
```

-   Explanation of Error Codes:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Success |
    | `04` | The member is not linked to a LynkiD account. |

## 4. Notes <a id="note"></a>

### 4.1 Providing Correct Headers <a id="note-1"></a>

-   X-API-Key and X-Partner-ID are required for every request.

### 4.2 Identifying the Correct Gift ID <a id="note-2"></a>

-   The giftId must be obtained from the gift list API (get-list-gift) before calling this API.

### 4.3 Check Error Codes <a id="note-3"></a>

-   Use the code and message fields in the response to handle errors if they occur.

## 5. Next Steps <a id="next-step"></a>

-   Explore other APIs:
    -   `api-get-list-gift`: Retrieve the list of gifts.
    -   `api-redeem`: Redeem gifts.
-   Test the API:
    -   Use Postman or Curl to test and validate the returned data.
