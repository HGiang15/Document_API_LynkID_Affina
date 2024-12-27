# API Gửi yêu cầu đổi quà

API này cho phép các đối tác gửi yêu cầu đổi quà từ hệ thống LynkiD dựa trên **mã thành viên**, **mã quà tặng** và các chi tiết khác. API này hỗ trợ cả quà tặng vật lý và quà tặng điện tử, với các chi tiết cụ thể được cung cấp qua **Nội dung yêu cầu**.

---

## Mục lục

1. [Chi tiết API](#api-details)
    - [Tiêu đề](#headers)
    - [Nội dung yêu cầu](#request-body)
2. [Nội dung yêu cầu mẫu](#request)
3. [Phản hồi mẫu](#response)
    - [Trường hợp thành công](#success)
    - [Trường hợp thất bại](#failure)
4. [Ghi chú](#note)
    - [Xử lý số lượng và điểm](#note-1)
    - [Địa chỉ giao quà tặng vật lý](#note-2)
    - [Quản lý mã giao dịch](#note-3)
    - [Kiểm tra mã lỗi](#note-4)
5. [Các bước tiếp theo](#next-step)

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/request-redeem-gift`
-   **Phương pháp**: `POST`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu   | Bắt buộc | Mô tả                                     |
| -------------- | ------ | -------- | ----------------------------------------- |
| `X-API-Key`    | String | Có       | Mã định danh khóa API do LynkiD cung cấp. |
| `X-Partner-ID` | String | Có       | Mã định danh đối tác do LynkiD cung cấp.  |

### 1.2. Nội dung yêu cầu <a id="request-body"></a>

| Tên trường          | Kiểu      | Bắt buộc | Mô tả                                                                                              | Ví dụ                                                                                                                       |
| ------------------- | --------- | -------- | -------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `sessionId`         | String    | Có       | ID phiên duy nhất, được sử dụng làm OtpSession. API xác minh OTP sẽ yêu cầu điều này.              | `"abc123def456"`                                                                                                            |
| `partnerMemberCode` | String    | Có       | Mã thành viên ở phía đối tác.                                                                      | `"PARTNER001"`                                                                                                              |
| `transactionCode`   | String    | Không    | Mã giao dịch duy nhất do đối tác tạo. Nếu không cung cấp, hệ thống sẽ tự động tạo một mã.          | `"TXN001"`                                                                                                                  |
| `amount`            | int | Có       | Số điểm cần thiết để đổi quà. Sử dụng trường `requiredCoin` và nhân với `quantity` nếu lớn hơn 1.  | `100`                                                                                                                       |
| `quantity`          | int | Có       | Số lượng quà tặng cần đổi. Giá trị mặc định là 1.                                                  | `1`                                                                                                                         |
| `giftCode`          | String    | Có       | Mã quà tặng cần đổi.                                                                               | `"GIFT001"`                                                                                                                 |
| `description`       | String    | Không    | Đối với quà tặng vật lý, trường này chứa thông tin chi tiết về địa chỉ giao hàng ở định dạng JSON. | `'{"fullName":"John Doe", "phone":"09xxxxxxx", "email":"email@email.com", "shipAddress":"123 Street, City, Country", ...}'` |

---

## 2. Nội dung yêu cầu mẫu <a id="request"></a>

### Đổi quà tặng điện tử:

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

**Khi trao đổi quà tặng vật lý, bạn cần điền vào định dạng sau**

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

> (Đối với C#, sử dụng Dictionary để nhập cặp khóa-giá trị; đối với Java, sử dụng DTO để giữ cặp khóa-giá trị và tuần tự hóa thành chuỗi.)

## Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
    "code": "00",
    "message": "Thành công"
}
```

### 3.2. Trường hợp thất bại <a id="failure"></a>

```json
{
    "code": "01",
    "message": "Mã thành viên đối tác không có kết nối"
}
```

### 3.3 Giải thích về các trường phản hồi

| Tên trường | Kiểu   | Mô tả                                                                              | Ví dụ |
| ---------- | ------ | ---------------------------------------------------------------------------------- | ----- |
| `code`     | String | Mã lỗi. `00` biểu thị thành công. Đối với những trường khác, hãy kiểm tra message. | `00`  |
| `message`  | String | Thông báo lỗi chi tiết.                                                            | `00`  |

-   Giải thích về các trường phản hồi
    | Mã | Mô tả |
    | ---------- | ------ |
    | `00` | Thành công: Yêu cầu đổi quà đã được tạo. |
    | `01` | Thành viên không được kết nối với hệ thống LynkiD. |
    | `04` | Mã quà không hợp lệ. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Xử lý số lượng và điểm <a id="note-1"></a>

-   Đảm bảo số tiền được tính toán chính xác (sử dụng requiredCoin \* amount).

### 4.2 Địa chỉ giao quà thực tế <a id="note-2"></a>

-   Trường mô tả phải bao gồm thông tin chi tiết về việc giao hàng đầy đủ ở định dạng JSON.

### 4.3 Quản lý Mã giao dịch <a id="note-3"></a>

-   Đảm bảo transactionCode là duy nhất để tránh xung đột.

### 4.4 Kiểm tra Mã lỗi <a id="note-4"></a>

-   Sử dụng các trường mã và tin nhắn để xác định trạng thái và xử lý lỗi một cách phù hợp.

## 5. Các bước tiếp theo <a id="next-step"></a>

-   Xác nhận yêu cầu đổi quà bằng OTP:
-   Sử dụng API `verify-otp-redeem-gift` để hoàn tất quy trình đổi quà.
-   Kiểm tra lịch sử đổi quà:
-   Sử dụng API `get-redeem-transaction` để xem lại các giao dịch đã hoàn tất.
