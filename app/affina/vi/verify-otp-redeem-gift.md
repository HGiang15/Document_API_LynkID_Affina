# API Xác minh OTP để Đổi quà

API này xác nhận OTP mà người dùng nhận được để hoàn tất giao dịch đổi quà. Khi thành công, API trả về mã giao dịch quà tặng và danh sách mã eGift (nếu có).

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
    -   [Xác thực OTP đúng](#note-1)
    -   [Xử lý nhiều mã eGift](#note-2)
    -   [Quản lý mã giao dịch](#note-3)
    -   [Kiểm tra mã lỗi](#note-4)
5. [Các bước tiếp theo](#next-step)

---

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/verify-otp-redeem-gift`
-   **Phương pháp**: `POST`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu  | Bắt buộc | Mô tả                                     |
| -------------- | ----- | -------- | ----------------------------------------- |
| `X-API-Key`    | String | Có       | Mã định danh khóa API do LynkiD cung cấp. |
| `X-Partner-ID` | String | Có       | Mã định danh đối tác do LynkiD cung cấp.  |

### 1.2. Nội dung yêu cầu <a id="request-body"></a>

| Tên trường          | Kiểu  | Bắt buộc | Mô tả                                                 | Ví dụ            |
| ------------------- | ----- | -------- | ----------------------------------------------------- | ---------------- |
| `sessionId`         | String | Có       | ID phiên do API `/affina/request-redeem-gift` tạo ra. | `"abc123def456"` |
| `partnerMemberCode` | String | Có       | Mã thành viên từ phía đối tác.                        | `"PARTNER001"`   |
| `otpCode`           | String | Có       | Mã OTP do người dùng nhận được.                       | `"191203"`       |

---

## 2. Nội dung yêu cầu mẫu <a id="request"></a>

```json
{
    "sessionId": "abc123def456",
    "otpCode": "191203",
    "partnerMemberCode": "PARTNER001"
}
```

## 3. Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

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
    "message": "Thành công"
}
```

-   Giải thích về các trường phản hồi:
    | **Tên trường** | **Loại** | **Mô tả** | **Ví dụ** |
    |--------------------------|------------|----------------------------------------------------------------------------------------------------|---------------------------|
    | `partnerMemberCode` | String | Mã thành viên đối tác. | `"PARTNER001"` |
    | `giftTransactionCode` | String | Mã giao dịch quà tặng. | `"Tx_CODE_000001"` |
    | `egifts` | Array | Danh sách mã eGift (nếu số lượng > 1, nhiều mã eGift sẽ được liệt kê). | Xem các trường bên trong `egifts`. |
    | `code` | String | Biểu thị trạng thái phản hồi. `"00"` có nghĩa là thành công. | `"00"` |
    | `message` | String | Thông báo trạng thái chi tiết hoặc thông báo lỗi. | `"Thành công"` |

-   Các trường bên trong `egifts`:

| **Tên trường** | **Loại** | **Mô tả**                                             | **Ví dụ**                        |
| -------------- | -------- | ----------------------------------------------------- | -------------------------------- |
| `eGiftCode`    | String    | Mã eGift đã đổi.                                      | `"EGIFTCODE_001"`                |
| `qrCode`       | String    | Liên kết đến hình ảnh QR hoặc Mã vạch cho mã eGift.   | `"http://qrcode.provider?xxxxx"` |
| `description`  | String    | Mô tả chi tiết về eGift (nếu có).                     | `""`                             |
| `status`       | String    | Trạng thái của eGift (`"A"` nghĩa là Đang hoạt động). | `"A"`                            |
| `expiredDate`  | Date     | Ngày hết hạn của eGift.                               | `"2024-06-13T19:16:57.767"`      |

### 3.2. Trường hợp lỗi <a id="failure"></a>

> Lý do phản hồi có egifts dưới dạng một mảng là vì số lượng trường hợp > 1, sẽ tạo ra nhiều mã egift.
> Mẫu JSON cho trường hợp lỗi:

```json
{
    "code": "1025",
    "message": "Hết hàng"
}
```

-   Giải thích mã lỗi:
    | Mã | Mô tả |
    | ---------- | ------ |
    | `00` | Thành công: Quá trình đổi quà đã hoàn tất. |
    | `1025` | Quà đã yêu cầu đã hết hàng. |
    | `1026` | Mã OTP không hợp lệ. |
    | `1027` | Mã OTP đã hết hạn. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Xác thực OTP chính xác <a id="note-1"></a>

-   Đảm bảo mã OTP khớp với mã được gửi qua SMS hoặc email.

### 4.2 Xử lý nhiều mã eGift <a id="note-2"></a>

-   Nếu số lượng > 1, hệ thống sẽ trả về danh sách các mã eGift (bên trong mảng egifts).

### 4.3 Quản lý mã giao dịch <a id="note-3"></a>

-   Lưu giftTransactionCode để tham khảo trong tương lai hoặc quản lý giao dịch tiếp theo.

### 4.4 Kiểm tra mã lỗi <a id="note-4"></a>

-   Sử dụng các trường mã và tin nhắn để xác định trạng thái giao dịch và xử lý lỗi.

## 5. Các bước tiếp theo <a id="next-step"></a>
-   Xem lại Lịch sử đổi quà:
-   Sử dụng API `get-redeem-transaction` để xem lịch sử giao dịch đổi quà.
-   Truy xuất Chi tiết giao dịch:
-   Sử dụng API `get-redeem-tx-detail` để xem thông tin chi tiết về các giao dịch cụ thể.
