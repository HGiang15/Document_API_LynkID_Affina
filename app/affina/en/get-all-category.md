# API Get Gift Category List

This API allows partners to query the list of available gift categories in the LynkiD system. The API returns information about each gift category, including category code, name, description, and image.

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
    - [Pagination Search](#note-1)
    - [Correct Headers](#note-2)
    - [Check Error Codes](#note-3)
    - [Ensure Proper Data](#note-4)

## 1. API Details <a id="api-details"></a>

- **Endpoint**: `/affina/get-all-category`
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
| `codeFilter`     | String  | No       | Search by category code.                     | `cat001`   |
| `nameFilter`     | String  | No       | Search by category name.                     | `Gift`     |
| `skipCount`      | Integer | No       | Used for pagination, default is 0.           | `0`        |
| `maxResultCount` | Integer | No       | Used for pagination, default is 10.          | `10`       |

---

## 2. Sample Request <a id="request"></a>

```http
[rootURL]/affina/get-all-category?codeFilter=cat001&nameFilter=Gift&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Sample Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

```json
{
    "code": "00",
    "message": null,
    "totalCount": 2,
    "items": [
        {
            "id": 307,
            "code": "4fa36bf4-58a9-4c08-8226-f0c355529bdb",
            "name": "Gift",
            "description": "{\"title\":\"\",\"content\":\"Gift\"}",
            "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/44573e38f2fd148d2011e2b711c2beb0.png",
            "parentCode": null
        },
        {
            "id": 262,
            "code": "1ca24093-ee67-4bf2-a5db-5a5941d0d7a9",
            "name": "Fashion",
            "description": "{\"title\":\"\",\"content\":\"Fashion\"}",
            "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/680f145c222654a8b3bf92c21526244a.png",
            "parentCode": null
        }
    ]
}
```

-   Explanation of Response Fields:

    | **Field Name**    | **Type**   | **Description**                                                                 | **Example**                                                                                                                                                       |
|-------------------|------------|---------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `code`            | string     | Indicates the status of the response.                                           | `00`                                                                                                                                                             |
| `message`         | String     | Indicates status details.                                                       | `Success`                                                                                                                                                        |
| `totalCount`      | int        | Total number of records returned.                                                | `2`                                                                                                                                                              |
| `items`           | array      | List of categories returned.                                                     | See below.                                                                                                                                                       |
| `id`              | string     | Category code identifier.                                                        | `4fa36bf4-58a9-4c08-8226-f0c355529bdb`                                                                                                                          |
| `code`            | string     | Category code.                                                                   | `cat001`                                                                                                                                                         |
| `name`            | string     | Category name.                                                                   | `Gift`                                                                                                                                                           |
| `description`     | string     | Description of the category. Currently used in JSON string format for other purposes. | `{"title":"Gift","content":"Gift"}`                                                                                                                              |
| `link`            | string     | Image URL of the category.                                                       | `https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/680f145c222654a8b3bf92c21526244a.png`                                                        |
| `parentCode`      | string     | Parent category code, not currently used in this scope.                         | `null`                                                                                                                                                           |
                                                                                                 |

### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "04",
    "message": "No categories found.",
    "totalCount": 0,
    "items": []
}
```

-   Explanation of Error Codes:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Success |
    | `04` | No categories found matching the filters provided. |

## 4. Notes <a id="note"></a>

### 4.1 Pagination Search <a id="note-1"></a>

-   Use skipCount and maxResultCount for pagination when there are multiple results.

### 4.2 Passing Correct and Complete Headers <a id="note-2"></a>

-   Ensure that X-API-Key and X-Partner-ID are provided correctly for each request.

### 4.3 Check Error Codes <a id="note-3"></a>

-   Error code 04 may occur if no categories matching the filters are found.

### 4.4 Ensure Proper Data <a id="note-4"></a>

-   Ensure that the filter parameters (codeFilter, nameFilter) are entered correctly to avoid errors.
