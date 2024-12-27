# API Submit Gift Redemption Request

This API allows partners to submit a gift redemption request from the LynkiD system based on the **member code**, **gift code**, and other details. It supports both physical gifts and eGifts, with specific details provided via the **Request Body**.

---

## Table of Contents

1. [API Details](#api-details)
    - [Headers](#headers)
    - [Request Body](#request-body)
2. [Sample Request Body](#request)
3. [Sample Response](#response)
    - [Success Case](#success)
    - [Failure Case](#failure)
4. [Notes](#note)
    - [Handling Quantity and Points](#note-1)
    - [Physical Gift Shipping Address](#note-2)
    - [Transaction Code Management](#note-3)
    - [Check Error Codes](#note-4)
5. [Next Steps](#next-step)

## 1. API Details <a id="api-details"></a>

- **Endpoint**: `/affina/request-redeem-gift`
- **Method**: `POST`
- **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| Header Name     | Type   | Required | Description                                   |
| --------------- | ------ | -------- | --------------------------------------------- |
| `X-API-Key`     | String | Yes      | API key identifier provided by LynkiD.        |
| `X-Partner-ID`  | String | Yes      | Partner identifier provided by LynkiD.        |

### 1.2. Request Body <a id="request-body"></a>

| Field Name          | Type    | Required | Description                                                                                                                | Example                                                                                                                                              |
| ------------------- | ------- | -------- | -------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sessionId`         | String  | Yes      | A unique session ID, used as OtpSession. This will be required by the OTP verification API.                                 | `"abc123def456"`                                                                                                                                    |
| `partnerMemberCode` | String  | Yes      | The member code on the partner's side.                                                                                      | `"PARTNER001"`                                                                                                                                      |
| `transactionCode`   | String  | No       | A unique transaction code generated by the partner. If not provided, the system will generate one automatically.            | `"TXN001"`                                                                                                                                          |
| `amount`            | Integer | Yes      | The number of points required for redemption. Use the `requiredCoin` field and multiply by `quantity` if greater than 1.    | `100`                                                                                                                                               |
| `quantity`          | Integer | Yes      | The number of gifts to redeem. Default value is 1.                                                                          | `1`                                                                                                                                                 |
| `giftCode`          | String  | Yes      | The code of the gift to redeem.                                                                                            | `"GIFT001"`                                                                                                                                         |
| `description`       | String  | No       | For physical gifts, this field contains shipping address details in JSON format.                                            | `'{"fullName":"John Doe", "phone":"09xxxxxxxx", "email":"email@email.com", "shipAddress":"123 Street, City, Country", ...}'`                        |

---

## 2. Sample Request Body <a id="request"></a>

### Redeeming an eGift:

```json
{
    "sessionId": "abc123def456",
    "partnerMemberCode": "PARTNER001",
    "transactionCode": "TXN001",
    "amount": 100,
    "quantity": 1,
    "giftCode": "GIFT001",
    "description": ""
}
```

**When exchanging physical gifts, you need to fill in the following format**

```json
{
    "fullName": "Nguyễn Văn A",
    "phone": "09xxxxxxxx",
    "email": "email@email.com",
    "note": "some note",
    "gender": "M",
    "shipAddress": "free text",
    "cityId": "<id>",
    "districtId": "<id>",
    "wardId": "<id>"
}
```

> (For C#, use a Dictionary to input key-value pairs; for Java, use a DTO to hold the key-value pairs and serialize it to a string.)

## Sample Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

```json
{
    "code": "00",
    "message": "Success"
}
```

### 3.2. Failure Case <a id="failure"></a>

```json
{
    "code": "01",
    "message": "Partner Member Code Does Not Have A Connection"
}
```

### 3.3 Explanation of Response Fields

| Field Name | Type   | Description                                                                  | Example |
| ---------- | ------ | ---------------------------------------------------------------------------- | ----- |
| `code`     | String | Error code. `00` indicates success. For others, check message.               | `00`  |
| `message`  | String | Detailed error message.                                                      | `00`  |

-   Explanation of Response Fields
    | Code | Description |
    | ---------- | ------ |
    | `00` | Success: The gift redemption request has been created. |
    | `01` | The member is not connected to the LynkiD system. |
    | `04` | Invalid gift code. |

## 4. Notes <a id="note"></a>

### 4.1 Handling Quantity and Points <a id="note-1"></a>

-   Ensure the amount is calculated correctly (use requiredCoin \* quantity).

### 4.2 Physical Gift Shipping Address <a id="note-2"></a>

-   The description field must include complete shipping details in JSON format.

### 4.3 Transaction Code Management <a id="note-3"></a>

-   Ensure the transactionCode is unique to avoid conflicts.

### 4.4 Check Error Codes <a id="note-4"></a>

-   Use the code and message fields to determine the status and handle errors appropriately.

## 5. Next Steps <a id="next-step"></a>

-   Confirm the redemption request with OTP:
    -   Use the `verify-otp-redeem-gift` API to complete the redemption process.
-   Check gift redemption history:
    -   Use the `get-redeem-transaction` API to review completed transactions.