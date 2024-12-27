# API Nhận danh sách quà tặng

API này cho phép các đối tác truy vấn danh sách quà tặng có sẵn trong hệ thống LynkiD. Bạn có thể lọc kết quả theo danh mục mã hóa, phạm vi giá hoặc tìm kiếm từ khóa.

---

## Mục lục

1. [Chi tiết API](#api-details)
    - [Tiêu đề](#headers)
    - [Tham số truy vấn](#query-params)
2. [Mẫu yêu cầu](#request)
3. [Phản hồi mẫu](#response)
    - [Trường hợp thành công](#success)
    - [Trường hợp hợp thất bại](#failure)
4. [Ghi chú](#note)
    - [Phân trang](#note-1)
    - [Tìm từ khóa](#note-2)
    - [Truyền tiêu đề chính xác và đầy đủ](#note-3)
    - [Kiểm tra lỗi mã hóa](#note-4)

## 1. API chi tiết <a id="api-details"></a>

-   **Điểm cuối**: `/affina/get-list-gift`
-   **Phương pháp**: `GET`
-   ** Format dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tiêu đề tên    | Kiểu   | Kill | Description                                |
| -------------- | ------ | ---- | ------------------------------------------ |
| `Khóa X-API`   | String | Có   | API khóa mã định nghĩa do LynkiD cung cấp. |
| `X-Đối tác-ID` | String | Có   | Mã định danh do LynkiD cung cấp.           |

### 1.2. Tham số truy vấn <a id="query-params"></a>

#### Yêu cầu truy vấn String

| Tham số tên      | Kiểu   | Kill  | Description                                                        | Ví dụ      |
| ---------------- | ------ | ----- | ------------------------------------------------------------------ | ---------- |
| `Mã danh mục`    | String | Không | Nhập danh mục mã hóa để nhận danh sách quà tặng trong danh mục này | `cat001`   |
| `giáTừ`          | int    | Không | Tìm kiếm phạm vi giá                                               | `1000`     |
| `priceTo`        | int    | Không | Tìm kiếm phạm vi giá                                               | `5000`     |
| `từ khóa`        | String | Không | Tìm kiếm theo tên quà tặng hoặc mã quà tặng                        | `Quà tặng` |
| `bỏ qua`         | int    | Có    | Được sử dụng để phân trang, mặc định là `0`.                       | `0`        |
| `maxResultCount` | int    | Có    | Được sử dụng để phân trang, mặc định là `10`.                      | `10`       |

## 2. Yêu cầu mẫu <a id="request"></a>

### Yêu cầu

```http
[rootURL]/affina/get-list-gift?categoryCode=cat001&priceFrom=1000&priceTo=5000&keyword=Gift&skipCount= 0&maxResultCount=10 HTTP/1.1
Máy chủ: [BASE_URL]
Khóa X-API: KEY_API_CỦA BẠN
ID đối tác X: ID đối tác_CỦA BẠN
```

## 3. Mẫu phản hồi <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
    "items": [
        {
            "id": 40285,
            "code": "GiftInfor_20240508072906451_6843",
            "name": "Test Gift 4 updated info",
            "description": "Test Gift 4 updated info",
            "shortDescription": "Test Gift 4 updated info",
            "requiredCoin": 2000.0,
            "categoryCode": "8e0e8cfa-b05c-4899-94fe-1833d6232528",
            "inStock": 10.0,
            "isEgift": true,
            "vendor": "LinkID",
            "brandName": "Phúc Long",
            "expireDuration": null,
            "totalWish": 0,
            "imageLinks": [
                {
                    "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/08791eb1e5a5276bd7e0d0d30f56fa47.xlsx",
                    "fullLink": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/08791eb1e5a5276bd7e0d0d30f56fa47.xlsx"
                }
            ]
        }
    ],
    "totalCount": 349,
    "code": "00",
    "message": null
}
```

-   Giải thích về các trường phản hồi

| **Trường tên**    | **Loại** | **Mô tả**                                                       | **Ví dụ**    |
| ----------------- | -------- | --------------------------------------------------------------- | ------------ |
| `code`              | String   | Chỉ ra trạng thái phản hồi.                                     | `00`         |
| `message`        | String   | Chỉ ra trạng thái chi tiết.                                     | `Thành công` |
| `các trường khác` |          | Trong mẫu JSON, ý nghĩa của các trường được giải thích rõ ràng. |              |

-   Các trường bên trong `items`:

| **Trường tên**      | **Loại** | **Mô tả**                                                           | **Ví dụ**                                    |
| ------------------- | -------- | ------------------------------------------------------------------- | -------------------------------------------- |
| `id`                | int      | Mã quà tặng.                                                        | `40285`                                      |
| `code`                | String   | Mã quà tặng.                                                        | `GiftInfor_20240508072906451_6843`           |
| `name`               | String   | Quà tặng tên.                                                       | `Thông tin cập nhật về thử nghiệm quà tặng ` |
| `description`             | String   | Mô tả chi tiết về quà tặng.                                         | `Thông tin cập nhật về thử nghiệm quà tặng ` |
| `shortDescription`        | String   | Mô tả ngắn về quà tặng.                                             | `Thông tin cập nhật về thử nghiệm quà tặng ` |
| `requiredCoin`          | int      | Điểm cần có để đổi quà.                                             | `2000.000000000000000000000000000000`        |
| `categoryCode`       | String   | Mã danh mục quà tặng.                                               | `8e0e8cfa-b05c-4899-94fe-1833d6232528`       |
| `inStock`          | int      | Số quà tặng có sẵn trong kho.                                       | `10.00000000000000000000000000000000`        |
| `isEgift`           | String   | Quà tặng phải là eGift không (true: eGift, false: quà tặng vật lý). | `đúng`                                       |
| `vendor`      | String   | Nhà cung cấp quà tặng.                                              | `LinkID`                                     |
| `brandName`   | String   | Tên quà tặng quà tặng.                                              | `Phúc Long`                                  |
| `expireDuration` | int      | Thời hạn hết hạn.                                                   | `null`                                       |
| `totalWish`         | int      | Tổng số mong muốn nhận quà.                                         | `0`                                          |
| `imageLinks` | String   | Danh sách liên kết hình ảnh cho món quà.                            |                                              |

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
    "mã": "04",
    "message": "Không tìm thấy quà tặng.",
    "tổng số": 0,
    "mặt hàng": []
}
```

-   Giải thích về lỗi mã hóa:
    | Trường tên | Loại |
    | ---------- | ------ |
    | `00` | Thành công |
    | `04` | Không tìm thấy quà tặng nào phù hợp với bộ lọc được cung cấp. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Phân trang <a id="note-1"></a>

-   Sử dụng SkipCount và maxResultCount để phân tích trang khi có nhiều kết quả.

### 4.2 Tìm kiếm từ khóa <a id="note-2"></a>

-   Khi sử dụng từ khóa, hãy đảm bảo từ khóa dài hơn 3 ký tự và không có khoảng trắng ở đầu hoặc cuối.

### 4.3 Truyền tiêu đề chính xác và đầy đủ <a id="note-3"></a>

-   X-API-Key và X-Partner-ID bị bắt buộc trong mọi yêu cầu.

### 4.4 Kiểm tra lỗi mã hóa <a id="note-4"></a>

-   Sử dụng các trường mã hóa và thông báo để xử lý các vấn đề nếu chúng xảy ra.
