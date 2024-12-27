# API khởi tạo liên kết giữa các thành viên Affina và LynkiD

API này khởi tạo liên kết giữa một thành viên **Affina** (được xác định bằng `partnerMemberCode`) và một thành viên **LynkiD** (được xác định bằng số điện thoại).
Sau khi khởi tạo thành công, một OTP sẽ được gửi đến số điện thoại đã cung cấp.
Liên kết sẽ chỉ được xác nhận sau khi xác minh OTP bằng API `/affina/verifyotp-lynkid-connection`.

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
    -   [Đảm bảo otpSession duy nhất](#note-1)
    -   [Số điện thoại hợp lệ](#note-2)
    -   [Xử lý số điện thoại bị chặn](#note-3)
    -   [Tên thành viên](#note-4)
5. [Các bước tiếp theo](#next-step)

---

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/init-lynkid-connection`
-   **Phương thức**: `POST`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu  | Bắt buộc | Mô tả                                    |
| -------------- | ----- | -------- | ---------------------------------------- |
| `X-API-Key`    | String | Có       | Khóa API do LynkiD cung cấp.             |
| `X-Partner-ID` | String | Có       | Mã định danh đối tác do LynkiD cung cấp. |

### 1.2. Nội dung yêu cầu <a id="request-body"></a>

| Tên trường            | Kiểu  | Kích thước | Bắt buộc | Mô tả                                                                      | Ví dụ                                    |
| --------------------- | ----- | ---------- | -------- | -------------------------------------------------------------------------- | ---------------------------------------- |
| `otpSession`          | String | Tối đa 255 | Có       | Mã định danh phiên OTP, phải là duy nhất trong hệ thống LynkiD.            | `"98a76b5c-4321-4e89-abcd-0123456789ab"` |
| `partnerMemberCode`   | String | Tối đa 255 | Có       | Mã định danh duy nhất của thành viên Affina.                               | `"PARTNER001"`                           |
| `partnerMemberName`   | String | Tối đa 255 | Không    | Tên của thành viên Affina (chỉ bắt buộc để tự động tạo thành viên LynkiD). | `"John Doe"`                             |
| `partnerMemberIdCard` | String | Tối đa 255 | Có       | Số thẻ căn cước của thành viên Affina.                                     | `"1234567890"`                           |
| `phoneNumber`         | String | Tối đa 255 | Có       | Số điện thoại của thành viên LynkiD để liên kết.                           | `"+849xxxxx"`                            |

#### **Yêu cầu mẫu JSON**

```json
{
    "otpSession": "98a76b5c-4321-4e89-abcd-0123456789ab",
    "partnerMemberCode": "PARTNER001",
    "partnerMemberName": "John Doe",
    "partnerMemberIdCard": "1234567890",
    "phoneNumber": "+1234567890"
}
```

## 3. Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
    "otpSession": "98a76b5c-4321-4e89-abcd-0123456789ab",
    "isOtpSent": true,
    "phoneNumber": "+1234567890",
    "code": "00",
    "message": "Thành công"
}
```

-   Giải thích về các trường phản hồi:

| Tên Trường    | Loại    | Mô Tả                                            | Ví Dụ                                    |
| ------------- | ------- | ------------------------------------------------ | ---------------------------------------- |
| `otpSession`  | String   | Phiên OTP đã được tạo.                           | `"98a76b5c-4321-4e89-abcd-0123456789ab"` |
| `isOtpSent`   | Boolean | Chỉ ra liệu OTP đã được gửi thành công hay chưa. | `true`                                   |
| `phoneNumber` | String   | Số điện thoại mà OTP đã được gửi đến.            | `"+1234567890"`                          |
| `code`        | String   | Mã trạng thái phản hồi. `00` chỉ ra thành công.  | `"00"`                                   |
| `message`     | String   | Thông báo trạng thái chi tiết.                   | `"Thành công"`                           |

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
"code": "101",
"message": "OtpSession duplicated"
}
{
"code": "102",
"message": "PhoneNumber is temporary blocked for new OTP"
}
```

-   Mô tả mã lỗi:
    | Mã | Mô tả mã lỗi |
    | ---------- | ------ |
    | `00` | Thành công. OTP đã được gửi đến số điện thoại đã cung cấp. |
    | `101` | OtpSession bị trùng lặp và không thể tạo liên kết mới. |
    | `102` | Số điện thoại tạm thời bị chặn đối với OTP mới. |

## 4. Lưu ý <a id="note"></a>

### 4.1 Đảm bảo otpSession duy nhất <a id="note-1"></a>

-   otpSession phải do đối tác tạo ra và không được trùng lặp với bất kỳ phiên nào hiện có trong hệ thống.

### 4.2 Số điện thoại hợp lệ <a id="note-2"></a>

-   Số điện thoại phải theo định dạng quốc tế (bắt đầu bằng + và mã quốc gia).

### 4.3 Xử lý số điện thoại bị chặn <a id="note-3"></a>

-   Nếu số điện thoại bị chặn (lỗi 102), hãy đợi thời gian chờ được chỉ định trước khi thử lại.

### 4.4 Tên thành viên <a id="note-4"></a>

-   Trường partnerMemberName chỉ bắt buộc nếu đối tác có ý định tự động tạo thành viên LynkiD.

## 5. Các bước tiếp theo <a id="next-step"></a>

-   Xác minh OTP để hoàn tất liên kết:
-   Sử dụng API `verifyotp-lynkid-connection` để hoàn tất liên kết.
-   Kiểm tra trạng thái liên kết:
-   Sử dụng API khác để xác minh trạng thái liên kết của thành viên.
