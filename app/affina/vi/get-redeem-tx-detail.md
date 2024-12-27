# API Truy xuất Chi tiết Giao dịch Đổi quà

API này cho phép các đối tác truy vấn thông tin chi tiết về giao dịch đổi quà cụ thể bằng cách sử dụng **mã giao dịch** và **mã thành viên**. Thông qua API này, bạn có thể xem thông tin chi tiết về quà tặng, trạng thái giao dịch và dữ liệu liên quan.

---

## Mục lục

1. [Chi tiết API](#api-details)
    -   [Tiêu đề](#headers)
    -   [Yêu cầu](#request)
2. [Ví dụ về yêu cầu](#request)
3. [Ví dụ về phản hồi](#response)
    -   [Trường hợp thành công](#success)
    -   [Trường hợp lỗi](#failure)
4. [Ghi chú](#note)
    -   [Mã giao dịch hợp lệ](#note-1)
    -   [Cung cấp tiêu đề chính xác và đầy đủ](#note-2)
    -   [Phân tích trạng thái giao dịch](#note-3)

---

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/get-redeem-tx-detail`
-   **Phương thức**: `GET`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| **Tên tiêu đề** | **Loại** | **Bắt buộc** | **Mô tả**                                |
| --------------- | -------- | ------------ | ---------------------------------------- |
| `X-API-Key`     | Chuỗi    | Có           | Khóa API do LynkiD cung cấp.             |
| `X-Partner-ID`  | Chuỗi    | Có           | Mã định danh đối tác do LynkiD cung cấp. |

### 1.2. Tham số truy vấn <a id="query-params"></a>

| **Tên tham số**       | **Loại** | **Bắt buộc** | **Mô tả**                                                       | **Ví dụ**       |
| --------------------- | -------- | ------------ | --------------------------------------------------------------- | --------------- |
| `partnerMemberCode`   | Chuỗi    | Có           | Mã thành viên từ hệ thống đối tác.                              | `"PARTNER001"`  |
| `giftTransactionCode` | Chuỗi    | Có           | Mã giao dịch của quà tặng, được liên kết với partnerMemberCode. | `"TX_CODE_001"` |

---

## 2. Ví dụ về yêu cầu <a id="request"></a>

```http
[rootURL]/affina/get-redeem-tx-detail?partnerMemberCode=PARTNER001&giftTransactionCode=TX_CODE_001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Ví dụ về phản hồi <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
    "giftTransaction": {
        "code": "TX_CODE",
        "buyerCode": "LinkIDMemberCode",
        "ownerCode": "LinkIDMemberCode",
        "transferTime": null,
        "introduce": "",
        "giftCode": "GIFTCODE",
        "giftName": "GiftName",
        "quantity": 1,
        "coin": 1000,
        "date": "2024-05-14T11:24:05.7101773+07:00",
        "status": "Delivered",
        "giftId": 111,
        "totalCoin": 1000,
        "description": null,
        "transactionCode": "TXCode",
        "qrCode": "Http://url-img",
        "codeDisplay": "QRCode",
        "id": null,
        "linkShippingInfo": "Address",
        "serialNo": "Seri"
    },
    "imageLinks": ["http://linki-anhr/", "http://linki-anhr/url2"],
    "vendorInfo": {
        "type": null,
        "image": "http://link-anh",
        "hotLine": null,
        "id": 12,
        "vendorName": "VendorName"
    },
    "code": "00",
    "message": "Success"
}
```

-   Mô tả các trường phản hồi

| Tên trường      | Kiểu      | Mô tả                                                   | Ví dụ     |
| --------------- | --------- | ------------------------------------------------------- | --------- |
| giftTransaction | Object    | Thông tin chi tiết về giao dịch tặng quà.               |           |
| code            | String     | Mã trạng thái phản hồi. "00" biểu thị thành công.       | `00`      |
| message         | String     | Thông báo chi tiết về trạng thái giao dịch.             | `Success` |
| imageLinks      | Array      | Danh sách các liên kết hình ảnh liên quan đến quà tặng. |           |
| vendorInfo      | Object | Thông tin về nhà cung cấp quà tặng.                     |           |

-   Các trường bên trong `giftTransaction`:

| **Tên trường**   | **Kiểu** | **Mô tả**                                                   | **Ví dụ**            |
| ---------------- | -------- | ----------------------------------------------------------- | -------------------- |
| code             | String    | Mã giao dịch của quà tặng.                                  | `"TX_CODE"`          |
| buyersCode       | String    | Mã thành viên của người mua.                                | `"LinkIDMemberCode"` |
| ownerCode        | String   | Mã thành viên của chủ sở hữu quà tặng.                      | `"LinkIDMemberCode"` |
| transferTime     | String   | Thời gian chuyển (nếu có).                                  | `null`               |
| giftCode         | String   | Mã của quà tặng đã đổi.                                     | `"GIFTCODE"`         |
| giftName         | String   | Tên của quà tặng đã đổi.                                    | `"GiftName"`         |
| quantity         | int  | Số lượng của quà tặng đã đổi.                               | `1`                  |
| coin             | int  | Điểm được sử dụng để đổi.                                   | `1000`               |
| status           | String   | Trạng thái giao dịch (`Đã giao`, `Đang chờ`, `Đã từ chối`). | `"Đã giao"`          |
| giftId           | int  | ID nội bộ của quà tặng đã đổi trong hệ thống.               | `111`                |
| totalCoin        | int  | Tổng điểm được sử dụng để đổi.                              | `1000`               |
| description      | String   | Chi tiết bổ sung về quà tặng (nếu có).                      | `null`               |
| transactionCode  | String    | Mã giao dịch duy nhất cho quà tặng.                         | `"TXCode"`           |
| qrCode           | String    | Liên kết đến mã QR cho quà tặng đã đổi.                     | `"Http://url-img"`   |
| codeDisplay      | String    | Định dạng hiển thị mã QR hoặc mã vạch.                      | `"QRCode"`           |
| linkShippingInfo | String    | Thông tin địa chỉ giao hàng (nếu có).                       | `"Address"`          |
| serialNo         | String    | Số sê-ri của quà tặng đã đổi.                               | `"Seri"`             |

-   Các trường bên trong `vendorInfo`:

| **Tên trường** | **Loại**  | **Mô tả**                                         | **Ví dụ**           |
| -------------- | --------- | ------------------------------------------------- | ------------------- |
| type           | String     | Loại nhà cung cấp (nếu có).                       | `null`              |
| image          | String     | Liên kết đến logo hoặc hình ảnh của nhà cung cấp. | `"http://link-anh"` |
| hotLine        | String     | Đường dây nóng của nhà cung cấp (nếu có).         | `null`              |
| id             | int | ID nội bộ của nhà cung cấp trong hệ thống.        | `12`                |
| vendorName     | String     | Tên của nhà cung cấp.                             | `"VendorName"`      |

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
    "code": "1026",
    "message": "Không tìm thấy giao dịch"
}
```

-   Giải thích về mã lỗi:
    | Mã | Mô tả |
    | ---------- | ------ |
    | `00` | Thành công, trả về danh sách các giao dịch trao đổi quà tặng. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Mã giao dịch hợp lệ <a id="note-1"></a>

-   Đảm bảo giftTransactionCode thuộc về partnerMemberCode và đã được xử lý trong hệ thống

### 4.2 Cung cấp Tiêu đề chính xác và đầy đủ <a id="note-2"></a>

-   `X-API-Key` và `X-Partner-ID` là bắt buộc trong mọi yêu cầu.

### 4.3 Phân tích trạng thái giao dịch <a id="note-3"></a>

-   Kiểm tra trường trạng thái trong giftTransaction để biết trạng thái hiện tại của giao dịch (ví dụ: Đã giao, Đang chờ xử lý).
