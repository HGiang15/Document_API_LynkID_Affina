# Bắt đầu với LynkiD - Affina Integration API

Tài liệu này sẽ hướng dẫn bạn cách bắt đầu sử dụng API tích hợp giữa hệ thống **LynkiD** và **Affina**. Tài liệu bao gồm thiết lập môi trường, thực hiện các lệnh gọi API cơ bản và những điều quan trọng cần lưu ý.

---

## Mục lục

1. [Các bước thiết lập cơ bản](#set-up)
    - [Định dạng dữ liệu](#format)
    - [Cấu hình môi trường](#environment)
    - [Tiêu đề bắt buộc](#headers)
2. [Kiểm tra API đầu tiên của bạn](#test-api)
3. [Công cụ được đề xuất](#tools)
    - [Công cụ kiểm tra](#tool)
    - [Mẹo kiểm tra](#check)
4. [Ghi chú](#note)
5. [Những việc cần làm tiếp theo](#next-step)

## 1. Các bước thiết lập cơ bản <a id="set-up"></a>

### 1.1. Định dạng dữ liệu <a id="format"></a>

- Tất cả **đầu vào** và **đầu ra** cho API đều sử dụng định dạng **JSON**.
- Đảm bảo kiểm tra định dạng yêu cầu và phản hồi trước khi gửi hoặc xử lý chúng.

### 1.2. Cấu hình môi trường <a id="environment"></a>

Sử dụng **URL cơ sở** sau cho các môi trường khác nhau:

> **UAT (Kiểm tra):** `[UAT_BASE_URL]`

> **Sản xuất (Triển khai):** `[PROD_BASE_URL]`

### 1.3. Tiêu đề bắt buộc <a id="headers"></a>

Mỗi yêu cầu cần bao gồm các tiêu đề sau:

> **`X-API-Key`**: Mã định danh khóa API (do LynkiD cung cấp).

> **`X-Partner-ID`**: Mã định danh đối tác (do LynkiD cung cấp).

Ví dụ:

```http
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 2. Kiểm tra API đầu tiên của bạn <a id="test-api"></a>

### API mẫu: Xem Điểm LynkiD

- Điểm cuối: /affina/view-point
- Phương pháp: `GET`
- Tham số truy vấn:

- partnerMemberCode (bắt buộc): Mã định danh thành viên đối tác.

- Ví dụ yêu cầu

```
GET /affina/view-point?partnerMemberCode=AFCODE0001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

- Ví dụ phản hồi (Thành công)

```json
{
"partnerMemberCode": "P_MemberCode_01",
"lynkiDWallet": "f8e1facb995f0e2cf9eaebab95ce62f273fc07",
"balance": 1000000,
"expiringBalance": 12000,
"code": "00",
"message": "Thành công",
"messageDetail": null
}
```

- Ví dụ phản hồi (Lỗi)

```json
{
"partnerMemberCode": "P_MemberCode_01",
"lynkiDWallet": null,
"balance": 0,
"expiringBalance": null,
"code": "04",
"message": "Thành viên đối tác không được kết nối với tài khoản LynkiD",
"messageDetail": null
}
```

## 3. Công cụ được đề xuất <a id="tools"></a>

### 3.1. Công cụ kiểm tra <a id="tool"></a>

- Bạn có thể sử dụng các công cụ sau để gọi và kiểm tra API:
- Postman: Giao diện thân thiện với người dùng để kiểm tra API.
- Curl: Công cụ kiểm tra nhanh thông qua lệnh terminal.
- Insomnia: Một giải pháp thay thế nhẹ cho Postman.

### 3.2. Mẹo kiểm tra <a id="check"></a>

- Đảm bảo tất cả tiêu đề và tham số truy vấn được cung cấp chính xác.
- So khớp mã lỗi trong phản hồi (mã, thông báo) để xác định sự cố nếu yêu cầu không thành công

## 4. Ghi chú <a id="note"></a>

- API sử dụng cơ chế bảo mật dựa trên Khóa API đáng tin cậy và IP trong Danh sách trắng.
- Cặp X-API-Key và X-Partner-ID là duy nhất cho mỗi đối tác và không được chia sẻ công khai.
- Đảm bảo kiểm tra định dạng JSON của cả yêu cầu và phản hồi để tránh lỗi định dạng.

## 5. Tiếp theo phải làm gì? <a id="next-step"></a>

- Đọc thêm: Khám phá thông tin chi tiết về các API bên dưới để hiểu từng API:
- `api-view-point`: Xem điểm.
- `api-category`: Quản lý danh mục quà tặng.
- `api-redeem`: Đổi quà tặng.
- `api-get-redeem-transaction`: Lịch sử đổi quà tặng.
- Kiểm tra thêm: Tích hợp các API khác vào hệ thống của bạn dựa trên các hướng dẫn chi tiết.