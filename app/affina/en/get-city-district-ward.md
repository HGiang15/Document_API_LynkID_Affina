# API Get City, District, Ward List

This API allows querying administrative levels (City, District, Ward) within the system. Users can filter data by administrative level, parent code, name, code, or ID, and use pagination to optimize results.

---

## Table of Contents

1. [API Details](#api-details)
    - [Headers](#headers)
    - [Request Query String](#query-params)
2. [Example Request](#request)
3. [Example Response](#response)
    - [Success Case](#success)
    - [Failure Case](#failure)
4. [Notes](#note)
    - [Pagination](#note-1)
    - [Valid Input](#note-2)
    - [Search by Parent Level](#note-3)

## 1. API Details <a id="api-details"></a>

-   **Endpoint**: `/affina/get-city-district-ward`
-   **Method**: `GET`
-   **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| Header Name    | Type   | Required | Description                    |
| -------------- | ------ | -------- | ------------------------------ |
| `X-API-Key`    | String | Yes      | API key provided by LynkiD.    |
| `X-Partner-ID` | String | Yes      | Partner ID provided by LynkiD. |

### 1.2. Query Params <a id="query-params"></a>

#### Request Query String

| Parameter Name     | Type    | Required | Description                                                     | Example        |
| ------------------ | ------- | -------- | --------------------------------------------------------------- | -------------- |
| `levelFilter`      | String  | Yes      | The administrative level to query (`City`, `District`, `Ward`). | `"City"`       |
| `codeFilter`       | String  | No       | Filter by the administrative code.                              | `"66"`         |
| `parentCodeFilter` | String  | Yes      | Parent code of the current administrative level.                | `"Vietnamese"` |
| `nameFilter`       | String  | No       | Filter by name.                                                 | `"An Giang"`   |
| `idFilter`         | Integer | No       | Filter by ID.                                                   | `30829`        |
| `skipCount`        | Integer | Yes      | Pagination parameter, default is 0.                             | `0`            |
| `maxResultCount`   | Integer | Yes      | Pagination parameter, default is 10.                            | `10`           |

---

## 2. Example Request <a id="request"></a>

```http
[rootURL]/affina/get-city-district-ward?levelFilter=City&parentCodeFilter=Vietnamese&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Example Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

> When querying with `levelFilter = City`

```json
{
    "totalCount": 64,
    "items": [
        {
            "id": 30829,
            "code": "66",
            "name": "An Giang",
            "description": "City",
            "parentCode": "Vietnamese",
            "internalCode": "66",
            "level": "City"
        },
        {
            "id": 30830,
            "code": "67",
            "name": "Bà Rịa - Vũng Tàu",
            "description": "City",
            "parentCode": "Vietnamese",
            "internalCode": "67",
            "level": "City"
        },
        {
            "id": 30831,
            "code": "81",
            "name": "Bắc Cạn",
            "description": "City",
            "parentCode": "Vietnamese",
            "internalCode": "81",
            "level": "City"
        },
        {
            "id": 30883,
            "code": "48",
            "name": "Quảng Trị",
            "description": "City",
            "parentCode": "Vietnamese",
            "internalCode": "48",
            "level": "City"
        }
    ],
    "code": "00",
    "message": null
}
```

-   Response Field Descriptions

| Field Name | Type    | Description                                   | Example            |
| ---------- | ------- | --------------------------------------------- | ------------------ |
| totalCount | Integer | Total number of records found.                | 64                 |
| items      | Array   | List of administrative units.                 | See details below. |
| code       | String  | Response status code. "00" indicates success. | "00"               |
| message    | String  | Detailed error message if any.                | null               |

---

-   Fields inside `items`

| Field Name   | Type    | Description                                         | Example      |
| ------------ | ------- | --------------------------------------------------- | ------------ |
| id           | Integer | ID of the administrative unit in the system.        | 30829        |
| code         | String  | Code of the administrative unit.                    | "66"         |
| name         | String  | Name of the administrative unit.                    | "An Giang"   |
| description  | String  | Type of administrative unit (City, District, Ward). | "City"       |
| parentCode   | String  | Parent code of the current administrative level.    | "Vietnamese" |
| internalCode | String  | Internal code of the administrative unit.           | "66"         |
| level        | String  | Administrative level (City, District, Ward).        | "City"       |

### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "1027",
    "message": "Invalid levelFilter or parentCodeFilter"
}
```

-   Error Code Descriptions:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Thành công, trả về danh sách các cấp hành chính. |
    | `1027` | levelFilter hoặc parentCodeFilter không hợp lệ. |

## 4. Notes <a id="note"></a>

### 4.1 Pagination <a id="note-1"></a>

-   Use skipCount and maxResultCount for paginated data retrieval.

### 4.2 Valid Input <a id="note-2"></a>

-   `levelFilter` and `parentCodeFilter` are required. Ensure accurate input to avoid errors.

### 4.3 Search by Parent Level <a id="note-3"></a>

-   When searching for Districts, provide the City code as parentCodeFilter. Similarly, for Wards, provide the District code.
