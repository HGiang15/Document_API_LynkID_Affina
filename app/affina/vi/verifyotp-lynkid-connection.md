# API xác minh OTP cho kết nối LynkiD

API này xác nhận OTP được gửi đến số điện thoại của khách hàng trong quá trình khởi tạo liên kết giữa thành viên **Affina** (được xác định bằng `partnerMemberCode`) và thành viên **LynkiD** (được xác định bằng số điện thoại).
Sau khi OTP được xác minh thành công, kết nối sẽ được thiết lập chính thức.

---

## Mục lục

1. [Chi tiết API](#api-details)
    -   [Tiêu đề](#headers)
    -   [Nội dung yêu cầu](#request-body)
2. [Nội dung yêu cầu mẫu](#request)
3. [Phản hồi mẫu](#response)
    -   [Trường hợp thành công](#success)
    -   [Trường hợp thất bại](#failure)
4. [Ghi chú](#note)
    -   [OTP hợp lệ](#note-1)
    -   [Xử lý lỗi otpSession trùng lặp](#note-2)
    -   [Số điện thoại hợp lệ](#note-3)
    -   [Số điện thoại bị chặn](#note-4)
5. [Các bước tiếp theo](#next-step)

## 1. Chi tiết API

-   **Điểm cuối**: `/affina/verifyotp-lynkid-connection`
-   **Phương pháp**: `POST`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề

| Tên tiêu đề    | Kiểu  | Bắt buộc | Mô tả                         |
| -------------- | ----- | -------- | ----------------------------- |
| `X-API-Key`    | String | Có       | Khóa API do LynkiD cung cấp   |
| `X-Partner-ID` | String | Có       | ID đối tác do LynkiD cung cấp |

### 1.2. Nội dung yêu cầu

| Tên trường    | Kiểu  | Kích thước | Bắt buộc | Mô tả                                                    | Ví dụ                                    |
| ------------- | ----- | ---------- | -------- | -------------------------------------------------------- | ---------------------------------------- |
| `otpSession`  | String | Tối đa 255 | Có       | Phiên OTP được tạo trong quá trình thiết lập kết nối.    | `"98a76b5c-4321-4e89-abcd-0123456789ab"` |
| `otpNumber`   | String | 255        | Có       | Mã OTP nhận được qua số điện thoại của khách hàng.       | `"129019"`                               |
| `phoneNumber` | String | Tối đa 255 | Có       | Số điện thoại của thành viên LynkiD để xác nhận kết nối. | `"+1234567890"`                          |

#### Ví dụ về yêu cầu JSON

```json
{
    "otpSession": "98a76b5c-4321-4e89-abcd-0123456789ab",
    "otpNumber": "129019",
    "phoneNumber": "+1234567890"
}
```

## 3. Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
 "otpSession": "98a76b5c-4321-4e89-abcd-0123456789ab",
 "isOtpSent": đúng,
 "Số điện thoại": "+1234567890",
 "mã": "00",
 "message": "Thành công"
}
```

-   Mô tả các trường trong Response

| Trường Tên      | Loại    | Mô Tả                                                | Ví Dụ                                    |
| --------------- | ------- | ---------------------------------------------------- | ---------------------------------------- |
| `otpSession`    | String   | Phiên bản OTP đã được sử dụng để xác nhận.           | `"98a76b5c-4321-4e89-abcd-0123456789ab"` |
| `isOtpSent`     | Boolean | Xác định OTP đã được gửi đến số điện thoại trước đó. | `đúng`                                   |
| `Số điện thoại` | String   | Số điện thoại được xác nhận liên kết.                | `"+1234567890"`                          |
| `mã`            | String   | Trạng thái phản hồi của mã. `"00"` đã thành công.    | `"00"`                                   |
| `tin nhắn`      | String   | Trạng thái phản hồi chi tiết của thông báo.          | `"Thành công"`                           |

### 3.2. Trường hợp lỗi <a id="failure"></a>

> Lỗi khi otpSession bị trùng lặp

```json
{
    "code": "101",
    "message": "OtpSession bị trùng lặp"
}
```

> Lỗi khi số điện thoại tạm thời bị chặn

```json
{
    "code": "102",
    "message": "Số điện thoại tạm thời bị chặn đối với OTP mới"
}
```

-   Mô tả mã lỗi:
    | Mã | Mô tả |
    | ------ ---- | ------ |
    | `00` | Thành công, OTP đã được xác minh, kết nối đã được thiết lập. |
    | `101` | OtpSession bị trùng lặp, không thể xác nhận OTP. |
    | `102` | Số điện thoại tạm thời bị chặn, không thể gửi hoặc xác minh OTP. |

## 4. Lưu ý <a id="note"></a>

### 4.1 OTP hợp lệ <a id="note-1"></a>

-   OTP phải khớp với mã được gửi đến số điện thoại trong khởi tạo kết nối.

### 4.2 Xử lý lỗi otpSession trùng lặp <a id="note-2"></a>

-   Đảm bảo rằng mỗi phiên OTP (otpSession) là duy nhất trong hệ thống.

### 4.3 Số điện thoại hợp lệ <a id="note-3"></a>

-   Số điện thoại phải theo định dạng quốc tế (bắt đầu bằng "+" và mã quốc gia).

### 4.4 Số điện thoại bị chặn <a id="note-4"> </a>

-   Nếu mã lỗi `102` được trả về, số điện thoại sẽ bị chặn tạm thời. Bạn phải đợi trong thời gian đã chỉ định trước khi thử lại.

## 5. Các bước tiếp theo <a id="next-step"></a>

-   Kiểm tra trạng thái kết nối:
-   Sử dụng các API liên quan để kiểm tra trạng thái kết nối của thành viên.
-   Bắt đầu giao dịch:
-   Sử dụng các API liên quan khác sau kết nối đã được thiết lập thành công.
