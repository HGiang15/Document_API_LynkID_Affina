# API Get Gift List

This API allows partners to query the list of available gifts in the LynkiD system. You can filter the results by category code, price range, or search by keyword.

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
    - [Keyword Search](#note-2)
    - [Passing Correct and Complete Headers](#note-3)
    - [Check Error Codes](#note-4)

## 1. API Details <a id="api-details"></a>

- **Endpoint**: `/affina/get-list-gift`
- **Method**: `GET`
- **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| Header Name     | Type   | Required | Description                                   |
| --------------- | ------ | -------- | --------------------------------------------- |
| `X-API-Key`     | String | Yes      | API key identifier provided by LynkiD.        |
| `X-Partner-ID`  | String | Yes      | Partner identifier provided by LynkiD.        |

### 1.2. Query Params <a id="query-params"></a>

#### Request Query String

| Parameter Name   | Type    | Required | Description                                  | Example    |
| ---------------- | ------- | -------- | -------------------------------------------- | ---------- |
| `categoryCode`   | String  | No       | Enter category code to get a list of gifts in this category | `cat001`   |
| `priceFrom`      | int     | No       | Search by price range                        | `1000`     |
| `priceTo`        | int     | No       | Search by price range                        | `5000`     |
| `keyword`        | String  | No       | Search by gift name or gift code             | `Gift`     |
| `skipCount`      | int     | Yes      | Used for pagination, default is `0`.         | `0`        |
| `maxResultCount` | int     | Yes      | Used for pagination, default is `10`.        | `10`       |

## 2. Sample Request <a id="request"></a>

### Request

```http
[rootURL]/affina/get-list-gift?categoryCode=cat001&priceFrom=1000&priceTo=5000&keyword=Gift&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Sample Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

```json
{
    "items": [
        {
            "id": 40285,
            "code": "GiftInfor_20240508072906451_6843",
            "name": "Test Gift 4 updated info",
            "description": "Test Gift 4 updated info",
            "shortDescription": "Test Gift 4 updated info",
            "requiredCoin": 2000.0,
            "categoryCode": "8e0e8cfa-b05c-4899-94fe-1833d6232528",
            "inStock": 10.0,
            "isEgift": true,
            "vendor": "LinkID",
            "brandName": "Phúc Long",
            "expireDuration": null,
            "totalWish": 0,
            "imageLinks": [
                {
                    "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/08791eb1e5a5276bd7e0d0d30f56fa47.xlsx",
                    "fullLink": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/08791eb1e5a5276bd7e0d0d30f56fa47.xlsx"
                }
            ]
        }
    ],
    "totalCount": 349,
    "code": "00",
    "message": null
}
```

-   Explanation of Response Fields

| **Field Name**      | **Type**   | **Description**                                                | **Example**                                  |
|---------------------|------------|----------------------------------------------------------------|----------------------------------------------|
| `code`             | string     | Indicates the status of the response.                         | `00`                                         |
| `message`          | String     | Indicates status details.                                     | `Success`                                   |
| `fields other`     |            | In the sample JSON, the meanings of fields are self-explanatory. |                                              |

-   Fields inside `items`:

| **Field Name**      | **Type**   | **Description**                                                | **Example**                                  |
|---------------------|------------|----------------------------------------------------------------|----------------------------------------------|
| `id`               | int        | Gift ID.                                                      | `40285`                                      |
| `code`             | String     | Gift code.                                                    | `GiftInfor_20240508072906451_6843`           |
| `name`             | String     | Gift name.                                                    | `Test Gift 4 updated info`                   |
| `description`      | String     | Detailed description of the gift.                             | `Test Gift 4 updated info`                   |
| `shortDescription` | String     | Short description of the gift.                                | `Test Gift 4 updated info`                   |
| `requiredCoin`     | int        | Points required to redeem the gift.                           | `2000.0000000000000000000000000`             |
| `categoryCode`     | String     | Category code of the gift.                                    | `8e0e8cfa-b05c-4899-94fe-1833d6232528`       |
| `inStock`          | int        | Quantity of the gift available in stock.                     | `10.000000000000000000000000000`             |
| `isEgift`          | String     | Whether the gift is an eGift (true: eGift, false: physical gift). | `true`                                       |
| `vendor`           | String     | Gift vendor.                                                 | `LinkID`                                     |
| `brandName`        | String     | Brand name of the gift.                                       | `Phúc Long`                                  |
| `expireDuration`   | int        | Expiration duration.                                          | `null`                                       |
| `totalWish`        | int        | Total wishes for the gift.                                    | `0`                                          |
| `imageLinks`       | String     | List of image links for the gift.                            |                                              |


### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "04",
    "message": "No gift found.",
    "totalCount": 0,
    "items": []
}
```

-   Explanation of Error Codes:
    | Tên Trường | Loại |
    | ---------- | ------ |
    | `00` | Success |
    | `04` | No gift found matching the filters provided. |

## 4. Notes <a id="note"></a>

### 4.1 Pagination <a id="note-1"></a>

-   Use skipCount and maxResultCount for pagination when there are multiple results.

### 4.2 Keyword Search <a id="note-2"></a>

-   When using the keyword, ensure the keyword is longer than 3 characters and does not have leading or trailing spaces.

### 4.3 Passing Correct and Complete Headers <a id="note-3"></a>

-   X-API-Key and X-Partner-ID are required in every request.

### 4.4 Check Error Codes <a id="note-4"></a>

-   Use the code and message fields to handle error situations if they occur.
