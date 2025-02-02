# API Verify OTP for Gift Redemption

This API confirms the OTP received by the user to complete a gift redemption transaction. Upon success, the API returns the gift transaction code and a list of eGift codes (if applicable).

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
    - [Validate Correct OTP](#note-1)
    - [Handle Multiple eGift Codes](#note-2)
    - [Manage Transaction Codes](#note-3)
    - [Check Error Codes](#note-4)
5. [Next Steps](#next-step)

---

## 1. API Details <a id="api-details"></a>

-   **Endpoint**: `/affina/verify-otp-redeem-gift`
-   **Method**: `POST`
-   **Data Format**: JSON

### 1.1. Headers <a id="headers"></a>

| Header Name    | Type   | Required | Description                            |
| -------------- | ------ | -------- | -------------------------------------- |
| `X-API-Key`    | String | Yes      | API key identifier provided by LynkiD. |
| `X-Partner-ID` | String | Yes      | Partner identifier provided by LynkiD. |

### 1.2. Request Body <a id="request-body"></a>

| Field Name          | Type   | Required | Description                                                    | Example          |
| ------------------- | ------ | -------- | -------------------------------------------------------------- | ---------------- |
| `sessionId`         | String | Yes      | Session ID generated by the `/affina/request-redeem-gift` API. | `"abc123def456"` |
| `partnerMemberCode` | String | Yes      | Member code from the partner's side.                           | `"PARTNER001"`   |
| `otpCode`           | String | Yes      | OTP code received by the user.                                 | `"191203"`       |

---

## 2. Sample Request Body <a id="request"></a>

```json
{
    "sessionId": "abc123def456",
    "otpCode": "191203",
    "partnerMemberCode": "PARTNER001"
}
```

## 3. Sample Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

```json
{
    "partnerMemberCode": "PARTNER001",
    "giftTransactionCode": "Tx_CODE_000001",
    "egifts": [
        {
            "eGiftCode": "EGIFTCODE_001",
            "qrCode": "http://qrcode.provider?xxxxx",
            "description": "",
            "status": "A",
            "expiredDate": "2024-06-13T19:16:57.767"
        }
    ],
    "code": "00",
    "message": "Success"
}
```

-   Explanation of Response Fields:
    | **Field Name** | **Type** | **Description** | **Example** |
    |--------------------------|------------|------------------------------------------------------------------|------------------------------|
    | `partnerMemberCode` | String | Partner member code. | `"PARTNER001"` |
    | `giftTransactionCode` | String | Gift transaction code. | `"Tx_CODE_000001"` |
    | `egifts` | Array | List of eGift codes (if quantity > 1, multiple eGift codes will be listed). | See fields inside `egifts`. |
    | `code` | String | Indicates the response status. `"00"` means success. | `"00"` |
    | `message` | String | Detailed status message or error message. | `"Success"` |

-   Fields inside `egifts`:

    | **Field Name** | **Type** | **Description**                                     | **Example**                      |
    | -------------- | -------- | --------------------------------------------------- | -------------------------------- |
    | `eGiftCode`    | String   | Redeemed eGift code.                                | `"EGIFTCODE_001"`                |
    | `qrCode`       | String   | Link to the QR or Barcode image for the eGift code. | `"http://qrcode.provider?xxxxx"` |
    | `description`  | String   | Detailed description of the eGift (if available).   | `""`                             |
    | `status`       | String   | Status of the eGift (`"A"` means Active).           | `"A"`                            |
    | `expiredDate`  | Date     | Expiration date of the eGift.                       | `"2024-06-13T19:16:57.767"`      |

### 3.2. Failure Case <a id="failure"></a>

> The reason the response has egifts as an array is because the case quantity > 1, will produce many egift codes.
> Sample JSON for error case:

```json
{
    "code": "1025",
    "message": "Out of stock"
}
```

-   Error Code Explanations:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Success: The gift redemption process is complete. |
    | `1025` | The requested gift is out of stock. |
    | `1026` | Invalid OTP code. |
    | `1027` | The OTP code has expired. |

## 4. Notes <a id="note"></a>

### 4.1 Validate Correct OTP <a id="note-1"></a>

-   Ensure the OTP code matches the one sent via SMS or email.

### 4.2 Handle Multiple eGift Codes <a id="note-2"></a>

-   If quantity > 1, the system will return a list of eGift codes (inside the egifts array).

### 4.3 Manage Transaction Codes <a id="note-3"></a>

-   Save the giftTransactionCode for future reference or further transaction management.

### 4.4 Check Error Codes <a id="note-4"></a>

-   Use the code and message fields to determine the transaction status and handle errors.

## 5. Next Steps <a id="next-step"></a>

-   Review Gift Redemption History:
    -   Use the `get-redeem-transaction` API to view redemption transaction history.
-   Retrieve Transaction Details:
    -   Use the `get-redeem-tx-detail` API to view detailed information about specific transactions.
