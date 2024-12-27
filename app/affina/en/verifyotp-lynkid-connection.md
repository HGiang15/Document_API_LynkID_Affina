# API Verify OTP for LynkiD Connection

This API confirms the OTP sent to the customer's phone number during the initialization of the link between an **Affina** member (identified by `partnerMemberCode`) and a **LynkiD** member (identified by phone number).  
Once the OTP is successfully verified, the connection will be officially established.

---

## Table of Contents

1. [API Details](#api-details)
    - [Headers](#headers)
    - [Request Body](#request-body)
2. [Example Request Body](#request)
3. [Example Response](#response)
    - [Success Case](#success)
    - [Failure Case](#failure)
4. [Notes](#note)
    - [Valid OTP](#note-1)
    - [Handle Duplicate otpSession Error](#note-2)
    - [Valid Phone Number](#note-3)
    - [Phone Number Blocked](#note-4)
5. [Next Steps](#next-step)

## 1. API Details

-   **Endpoint**: `/affina/verifyotp-lynkid-connection`
-   **Method**: `POST`
-   **Data Format**: JSON

### 1.1. Headers

| Header Name    | Type   | Required | Description                   |
| -------------- | ------ | -------- | ----------------------------- |
| `X-API-Key`    | String | Yes      | API key provided by LynkiD    |
| `X-Partner-ID` | String | Yes      | Partner ID provided by LynkiD |

### 1.2. Request Body

| Field Name    | Type   | Size    | Required | Description                                                    | Example                                  |
| ------------- | ------ | ------- | -------- | -------------------------------------------------------------- | ---------------------------------------- |
| `otpSession`  | String | 255 max | Yes      | The OTP session generated during the connection setup process. | `"98a76b5c-4321-4e89-abcd-0123456789ab"` |
| `otpNumber`   | String | 255     | Yes      | The OTP received by the customer's phone number.               | `"129019"`                               |
| `phoneNumber` | String | 255 max | Yes      | The LynkiD member's phone number to confirm the connection.    | `"+1234567890"`                          |

#### Example Request JSON

```json
{
    "otpSession": "98a76b5c-4321-4e89-abcd-0123456789ab",
    "otpNumber": "129019",
    "phoneNumber": "+1234567890"
}
```

## 3. Example Response <a id="response"></a>

### 3.1. Success Case <a id="success"></a>

```json
{
    "otpSession": "98a76b5c-4321-4e89-abcd-0123456789ab",
    "isOtpSent": true,
    "phoneNumber": "+1234567890",
    "code": "00",
    "message": "Success"
}
```

-   Mô tả các trường trong Response

| Tên Trường    | Loại    | Mô Tả                                                | Ví Dụ                                    |
| ------------- | ------- | ---------------------------------------------------- | ---------------------------------------- |
| `otpSession`  | String  | Phiên OTP đã được sử dụng để xác nhận.               | `"98a76b5c-4321-4e89-abcd-0123456789ab"` |
| `isOtpSent`   | Boolean | Xác định OTP đã được gửi đến số điện thoại trước đó. | `true`                                   |
| `phoneNumber` | String  | Số điện thoại được xác nhận liên kết.                | `"+1234567890"`                          |
| `code`        | String  | Mã trạng thái của response. `"00"` là thành công.    | `"00"`                                   |
| `message`     | String  | Thông báo chi tiết trạng thái của response.          | `"Success"`                              |

### 3.2. Failure Case <a id="failure"></a>

> Error when otpSession is duplicated

```json
{
    "code": "101",
    "message": "OtpSession duplicated"
}
```

> Error when phone number is temporarily blocked

```json
{
    "code": "102",
    "message": "PhoneNumber is temporarily blocked for new OTP"
}
```

-   Error Code Descriptions:
    | Code | Description |
    | ---------- | ------ |
    | `00` | Success, OTP has been verified, the connection is established. |
    | `101` | The otpSession is duplicated, unable to confirm OTP. |
    | `102` | The phone number is temporarily blocked, unable to send or verify OTP. |

## 4. Notes <a id="note"></a>

### 4.1 Valid OTP <a id="note-1"></a>

-   The OTP must match the code sent to the phone number during the connection initialization.

### 4.2 Handle Duplicate otpSession Error <a id="note-2"></a>

-   Ensure that each OTP session (otpSession) is unique within the system.

### 4.3 Valid Phone Number <a id="note-3"></a>

-   The phone number must follow the international format (starting with "+" and the country code).

### 4.4 Phone Number Blocked <a id="note-4"></a>

-   If error code `102` is returned, the phone number is temporarily blocked. You must wait the specified time before trying again.

## 5. Next Steps <a id="next-step"></a>

-   Check the connection status:
    -   Use related APIs to check the status of the member connection.
-   Start the transaction:
    -   Use other related APIs after the connection is successfully established.
