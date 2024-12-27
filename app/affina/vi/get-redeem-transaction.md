# API Kiểm tra Lịch sử Đổi quà

API này cho phép các đối tác truy vấn lịch sử đổi quà của các thành viên trong hệ thống LynkiD. Các đối tác có thể lọc kết quả theo ngày, trạng thái giao dịch, trạng thái eGift và phân trang kết quả.

---

## Mục lục

1. [Chi tiết API](#api-details)
    -   [Tiêu đề](#headers)
    -   [Tham số truy vấn](#query-params)
2. [Yêu cầu mẫu](#request)
3. [Phản hồi mẫu](#response)
    -   [Trường hợp thành công](#success)
    -   [Trường hợp thất bại](#failure)
4. [Ghi chú](#note)
    -   [Phân trang](#note-1)
    -   [Xử lý trạng thái giao dịch](#note-2)
    -   [Lọc theo trạng thái eGift](#note-3)
5. [Các bước tiếp theo](#next-step)

---

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/get-redeem-transaction`
-   **Phương thức**: `GET`
-   **Dữ liệu Định dạng**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| **Tên tiêu đề** | **Loại** | **Bắt buộc** | **Mô tả**                                 |
| --------------- | -------- | ------------ | ----------------------------------------- |
| `X-API-Key`     | String    | Có           | Mã định danh khóa API do LynkiD cung cấp. |
| `X-Partner-ID`  | String    | Có           | Mã định danh đối tác do LynkiD cung cấp.  |

### 1.2. Tham số truy vấn <a id="query-params"></a>

| **Tên trường**      | **Loại**  | **Bắt buộc** | **Mô tả**                                                          | **Ví dụ**               |
| ------------------- | --------- | ------------ | ------------------------------------------------------------------ | ----------------------- |
| `partnerMemberCode` | String     | Có           | Mã thành viên ở phía đối tác.                                      | `"PARTNER001"`          |
| `fromDate`          | DateTime  | Không        | Lọc các giao dịch từ ngày này. Mặc định là 30 ngày qua.            | `"2024-05-01T00:00:00"` |
| `toDate`            | DateTime  | Không        | Lọc các giao dịch cho đến ngày này.                                | `"2024-06-01T00:00:00"` |
| `statusFilter`      | String     | Không        | Trạng thái giao dịch (`Đã giao`, `Đã từ chối`, v.v.).              | `"Đã giao"`             |
| `eGiftStatusFilter` | String     | Không        | Trạng thái eGift (`Có sẵn`, `Đã đổi`, `Đã sử dụng`, `Đã hết hạn`). | `"Đã đổi"`              |
| `skipCount`         | int | Có           | Độ lệch phân trang. Mặc định là `0`.                               | `0`                     |
| `maxResultCount`    | int | Có           | Số lượng bản ghi trên mỗi trang. Mặc định là `10`.                 | `10`                    |

---

## 2. Yêu cầu mẫu <a id="request"></a>

```http
[rootURL]/affina/get-redeem-transaction?partnerMemberCode=PARTNER001&fromDate=2024-05-01T00:00:00&toDate=2024-06-01T00:00:00&statusFilter=Delivered&eGiftStatusFilter=Redeemed&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
    "count": 1,
    "items": [
        {
            "giftTransaction": {
                "code": "TX_CODE",
                "buyerCode": "LinkIDMemberCode",
                "ownerCode": "LinkIDMemberCode",
                "transferTime": null,
                "giftCode": "GIFTCODE",
                "giftName": "GiftName",
                "quantity": 1,
                "coin": 1000,
                "date": "2024-05-14T11:22:48.5075146+07:00",
                "status": "Delivered",
                "giftId": 111,
                "totalCoin": 1000,
                "description": null,
                "transactionCode": "TXCode",
                "qrCode": "http://url-img",
                "linkShippingInfo": "Địa chỉ",
                "serialNo": "Seri"
            },
            "imageLinks": ["http://linki-anhr/", "http://linki-anhr/url2"],
            "vendorInfo": {
                "type": null,
                "image": "http://link-anh",
                "hotLine": null,
                "id": 12,
                "vendorName": "VendorName"
            }
        }
    ],
    "code": "00",
    "message": "Thành công"
}
```

-   Giải thích về các trường phản hồi:

| **Tên trường** | **Loại** | **Mô tả**                                           | **Ví dụ**              |
| -------------- | -------- | --------------------------------------------------- | ---------------------- |
| `count`        | int      | Tổng số giao dịch được trả về.                      | `1`                    |
| `items`        | Array     | Danh sách các giao dịch đổi quà tặng.               | Xem chi tiết bên dưới. |
| `code`         | String    | Mã trạng thái phản hồi. `"00"` nghĩa là thành công. | `"00"`                 |
| `message`      | String    | Thông báo trạng thái chi tiết.                      | `"Success"`            |

-   Các trường bên trong `giftTransaction`:

| **Tên trường**     | **Loại** | **Mô tả**                                         | **Ví dụ**            |
| ------------------ | -------- | ------------------------------------------------- | -------------------- |
| `code`             | String    | Mã giao dịch.                                     | `"TX_CODE"`          |
| `buyerCode`        | String    | Mã thành viên người mua.                          | `"LinkIDMemberCode"` |
| `ownerCode`        | String    | Mã thành viên chủ sở hữu.                         | `"LinkIDMemberCode"` |
| `transferTime`     | String    | Thời gian chuyển nhượng (nếu có).                 | `null`               |
| `giftCode`         | String    | Mã quà tặng đã đổi.                               | `"GIFTCODE"`         |
| `giftName`         | String    | Tên của quà tặng đã đổi.                          | `"GiftName"`         |
| `quantity`         | int      | Số lượng quà tặng đã đổi.                         | `1`                  |
| `coin`             | int      | Điểm được sử dụng để đổi.                         | `1000`               |
| `status`           | String    | Trạng thái giao dịch (Đã giao, Đã từ chối, v.v.). | `"Đã giao"`          |
| `giftId`           | int      | ID nội bộ của quà tặng đã đổi.                    | `111`                |
| `totalCoin`        | int      | Tổng số điểm được sử dụng cho giao dịch.          | `1000`               |
| `description`      | String    | Mô tả giao dịch (nếu có).                         | `null`               |
| `transactionCode`  | String    | Mã giao dịch duy nhất cho quà tặng.               | `"TXCode"`           |
| `qrCode`           | String    | Liên kết mã QR cho quà tặng.                      | `"http://url-img"`   |
| `linkShippingInfo` | String    | Thông tin địa chỉ giao hàng (nếu có).             | `"Address"`          |
| `serialNo`         | String    | Số sê-ri của quà tặng đã đổi.                     | `"Seri"`             |

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
    "code": "1025",
    "message": "Hết hàng"
}
```

-   Giải thích mã lỗi:
    | Mã | Mô tả |
    | ---------- | ------ |
    | `00` | Thành công: Giao dịch đã được truy xuất thành công. |
    | `1025` | Quà tặng được yêu cầu đã hết hàng. |
    | `1026` | Tiêu chí tìm kiếm không hợp lệ (ví dụ: mã thành viên không đúng). |
    | `1027` | Không tìm thấy giao dịch nào trong phạm vi ngày đã chỉ định.|

## 4. Ghi chú <a id="note"></a>

### 4.1 Phân trang <a id="note-1"></a>

-   Sử dụng skipCount và maxResultCount cho kết quả được phân trang khi có nhiều bản ghi.

### 4.2 Xử lý Trạng thái Giao dịch <a id="note-2"></a>

-   Kiểm tra trường trạng thái để xác định xem giao dịch có thành công hay không.

### 4.3 Lọc theo Trạng thái eGift <a id="note-3"></a>

-   Sử dụng eGiftStatusFilter để lọc theo các trạng thái eGift cụ thể như Đã đổi, Đã sử dụng hoặc Đã hết hạn.

## 5. Các bước tiếp theo <a id="next-step"></a>

-   Xem Chi tiết giao dịch:
-   Sử dụng API `get-redeem-tx-detail` để biết thông tin chi tiết về giao dịch.
-   Hoàn tất đổi quà:
-   Sử dụng API `verify-otp-redeem-gift` để hoàn tất việc đổi quà.
