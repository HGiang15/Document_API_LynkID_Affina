# Error Codes Table

## 1. Overview

The error codes table lists the status codes returned by the LynkiD API system.  
Each error code has a specific meaning, helping partners easily identify and handle issues that arise when using the API.

---

> Error Codes Table

| **Error Code** | **Error Description**                                       |
|----------------|-------------------------------------------------------------|
| `00`           | Success                                                     |
| `100`          | Unknown Error, contact LynkiD for more info                 |
| `101`          | OtpSession duplicated                                       |
| `102`          | PhoneNumber is temporarily blocked for new OTP              |
| `200`          | Invalid partnerMemberCode                                   |
| `201`          | Connection not found for partnerMemberCode                  |
| `202`          | Insufficient points for redemption                          |
| `203`          | Gift out of stock                                           |
| `204`          | Invalid giftCode                                            |
| `300`          | Invalid levelFilter or parentCodeFilter                     |
| `301`          | No data found for the provided filters                      |

---

## 2. Notes

- **Error Code `00`**:
  - Success, no errors occurred. The response will return the corresponding data.
- **Error Code `100`**:
  - Unknown error, please contact LynkiD support team for more details.
- **Other Error Codes**:
  - These are used to indicate specific errors related to the connection process, gift redemption, or data queries.

---

## 3. Error Handling Instructions

1. **Error Code `100` (Unknown Error)**:
   - Contact the LynkiD support team via email or hotline for further information.
2. **Connection Errors (`200`, `201`)**:
   - Ensure that the `partnerMemberCode` provided is valid and that the connection is properly set up.
3. **Gift Redemption Errors (`202`, `203`, `204`)**:
   - Check the member’s points, the validity of the gift code (`giftCode`), and the stock availability.
4. **Data Query Errors (`300`, `301`)**:
   - Ensure that all filtering parameters (`levelFilter`, `parentCodeFilter`, etc.) are provided accurately and completely.

---

## 4. Future Error Code Updates

- **Additional Error Codes**:
  - There will be additional error codes related to:
    - Member connections.
    - Gift redemption process.
    - Checking connection status before querying data.

---

## 5. Contact Support

If you need further information or assistance when encountering errors, please contact the LynkiD support team:

- **Email**: support@lynkid.vn  
- **Hotline**: 1900-8386
