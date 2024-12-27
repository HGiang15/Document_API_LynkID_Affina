# API Xem Chi tiết Quà tặng

API này cho phép các đối tác lấy thông tin chi tiết về quà tặng dựa trên **ID Quà tặng**. Thông tin trả về bao gồm tên quà tặng, mô tả, điểm cần thiết, trạng thái và hình ảnh liên quan.

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
    -   [Cung cấp tiêu đề chính xác](#note-1)
    -   [Xác định ID quà tặng chính xác](#note-2)
    -   [Kiểm tra mã lỗi](#note-3)
5. [Các bước tiếp theo](#next-step)

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/get-gift-detail`
-   **Phương pháp**: `GET`
-   **Dữ liệu Định dạng**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu  | Bắt buộc | Mô tả                                     |
| -------------- | ----- | -------- | ----------------------------------------- |
| `X-API-Key`    | String | Có       | Mã định danh khóa API do LynkiD cung cấp. |
| `X-Partner-ID` | String | Có       | Mã định danh đối tác do LynkiD cung cấp.  |

### 1.2. Tham số truy vấn <a id="query-params"></a>

#### Chuỗi truy vấn yêu cầu

| Tên tham số | Kiểu | Bắt buộc | Mô tả                                      | Ví dụ   |
| ----------- | ---- | -------- | ------------------------------------------ | ------- |
| `giftId`    | int  | Có       | ID quà tặng lấy từ API danh sách quà tặng. | `40285` |

---

## 2. Yêu cầu mẫu <a id="request"></a>

### Yêu cầu

```http
[rootURL]/affina/get-gift-detail?giftId=40285 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Phản hồi mẫu <a id="response"></a>

### Trường hợp thành công <a id="success"></a>

```json
{
    "giftDetail": {
        "id": 35975,
        "code": "GiftInfor_20230302093022744_4534",
        "name": "GotIt Multi 15.000",
        "description": "<p>Sản phẩm đa dạng - Có thể sử dụng trên tất cả GOTIT hệ thống</p>\r\n<p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 16px; font-weight: bold\">**Điều kiện sử dụng: </p><p>- Phiếu quà tặng điện tử được cung cấp bởi Got It.</p>\r\n\r\n<p>- Một hóa đơn có thể sử dụng nhiều phiếu quà tặng, mỗi phiếu chỉ có giá trị sử dụng một lần theo các điều khoản đã chỉ định.</p>",
        "requiredCoin": 15000,
        "categoryCode": "4fa36bf4-58a9-4c08-8226-f0c355529bdb",
        "inStock": 999986,
        "isEgift": true,
        "vendorHotline": null,
        "vendor": "GotIt",
        "vendorImage": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/4672fca351761459c11a22bb695982d8.png",
        "vendorDescription": "Đã hiểu",
        "brandName": null,
        "brandLinkLogo": null,
        "brandAddress": null,
        "brandDescription": null,
        "imageLinks": [
            {
                "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/169be3b937f253cb41d56c1874bcdd19.png",
                "fullLink": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/169be3b937f253cb41d56c1874bcdd19.png"
            }
        ]
    },
    "mã": "00",
    "tin nhắn": null
}
```

-   Explanation of Response Fields:

| **Field Name**            | **Type** | **Description**                                                          | **Example**                                                                                              |
| ------------------------- | -------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- |
| `code`                    | String   | Indicates the status of the response.                                    | `00`                                                                                                     |
| `message`                 | String   | Indicates status details.                                                | `Success`                                                                                                |
| `giftDetail.name`         | String   | Name of the gift.                                                        | `GotIt Multi 15.000`                                                                                     |
| `giftDetail.description`  | String   | Detailed description of the gift.                                        | `<p>Product multi - Usable across all GOTIT systems</p>`                                                 |
| `giftDetail.requiredCoin` | int      | Number of points required to redeem the gift.                            | `15000`                                                                                                  |
| `giftDetail.categoryCode` | String   | Code of the category to which the gift belongs.                          | `4fa36bf4-58a9-4c08-8226-f0c355529bdb`                                                                   |
| `giftDetail.inStock`      | int      | Quantity of the gift available in stock.                                 | `999986`                                                                                                 |
| `giftDetail.isEgift`      | Boolean  | Indicates if the gift is an eGift (`true`) or a physical gift (`false`). | `true`                                                                                                   |
| `giftDetail.vendor`       | String   | Name of the gift's vendor.                                               | `GotIt`                                                                                                  |
| `giftDetail.vendorImage`  | String   | URL to the vendor's logo or image.                                       | `https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/4672fca351761459c11a22bb695982d8.png` |
| `giftDetail.imageLinks`   | Array    | A list of image links related to the gift.                               | See example above                                                                                        |

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
    "code": "04",
    "message": "Không tìm thấy quà tặng.",
    "giftDetail": null
}
```

-   Giải thích về mã lỗi:
    | Mã | Mô tả |
    | ---------- | ------ |
    | `00` | Thành công |
    | `04` | Thành viên không được liên kết với tài khoản LynkiD. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Cung cấp tiêu đề chính xác <a id="note-1"></a>

-   Cần có X-API-Key và X-Partner-ID cho mọi yêu cầu.

### 4.2 Xác định ID quà tặng chính xác <a id="note-2"></a>

-   GiftId phải được lấy từ API danh sách quà tặng (get-list-gift) trước khi gọi API này.

### 4.3 Kiểm tra mã lỗi <a id="note-3"></a>

-   Sử dụng các trường mã và thông báo trong phản hồi để xử lý lỗi nếu chúng xảy ra.

## 5. Các bước tiếp theo <a id="next-step"></a>

-   Khám phá các API khác:
-   `api-get-list-gift`: Truy xuất danh sách quà tặng.
-   `api-redeem`: Đổi quà tặng.
-   Kiểm tra API:
-   Sử dụng Postman hoặc Curl để kiểm tra và xác thực dữ liệu được trả về.
