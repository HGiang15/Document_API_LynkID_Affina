# API Nhận danh sách danh mục quà tặng

API này cho phép các đối tác truy vấn danh sách các danh mục quà tặng có sẵn trong hệ thống LynkiD. API trả về thông tin về từng danh mục quà tặng, bao gồm mã danh mục, tên, mô tả và hình ảnh.

---

## Mục lục

1. [Chi tiết API](#api-details)
    -   [Tiêu đề](#headers)
    -   [Tham số truy vấn](#query-params)
2. [Yêu cầu mẫu](#request)
3. [Phản hồi mẫu](#response)
    -   [Trường hợp thành công](#success)
    -   [Trường hợp lỗi](#failure)
4. [Ghi chú](#note)
    -   [Tìm kiếm phân trang](#note-1)
    -   [Tiêu đề chính xác](#note-2)
    -   [Kiểm tra mã lỗi](#note-3)
    -   [Đảm bảo dữ liệu phù hợp](#note-4)

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/get-all-category`
-   **Phương pháp**: `GET`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu  | Bắt buộc | Mô tả                                     |
| -------------- | ----- | -------- | ----------------------------------------- |
| `X-API-Key`    | String | Có       | Mã định danh khóa API do LynkiD cung cấp. |
| `X-Partner-ID` | String | Có       | Mã định danh đối tác do LynkiD cung cấp.  |

### 1.2. Tham số truy vấn <a id="query-params"></a>

#### Chuỗi truy vấn yêu cầu

| Tên tham số      | Kiểu      | Bắt buộc | Mô tả                                       | Ví dụ    |
| ---------------- | --------- | -------- | ------------------------------------------- | -------- |
| `codeFilter`     | String     | Không    | Tìm kiếm theo mã danh mục.                  | `cat001` |
| `nameFilter`     | String     | Không    | Tìm kiếm theo tên danh mục.                 | `Gift`   |
| `skipCount`      | int | Không    | Được sử dụng để phân trang, mặc định là 0.  | `0`      |
| `maxResultCount` | int | Không    | Được sử dụng để phân trang, mặc định là 10. | `10`     |

---

## 2. Yêu cầu mẫu <a id="request"></a>

```http
[rootURL]/affina/get-all-category?codeFilter=cat001&nameFilter=Gift&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

```json
{
    "code": "00",
    "message": null,
    "totalCount": 2,
    "items": [
        {
            "id": 307,
            "code": "4fa36bf4-58a9-4c08-8226-f0c355529bdb",
            "name": "Quà tặng",
            "description": "{\"title\":\",\"content\":\"Quà tặng\"}",
            "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/44573e38f2fd148d2011e2b711c2beb0.png",
            "parentCode": null
        },
        {
            "id": 262,
            "code": "1ca24093-ee67-4bf2-a5db-5a5941d0d7a9",
            "name": "Thời trang",
            "description": "{\"title\":\"\",\"content\":\"Thời trang\"}",
            "link": "https://linkidstorage.s3-ap-southeast-1.amazonaws.com/upload-gift/680f145c222654a8b3bf92c21526244a.png",
            "parentCode": null
        }
    ]
}
```

-   Giải thích về các trường phản hồi:

| **Tên trường** | **Loại** | **Mô tả**                           | **Ví dụ**                              |
| -------------- | -------- | ----------------------------------- | -------------------------------------- |
| `code`         | String   | Chỉ ra trạng thái của phản hồi.     | `00`                                   |
| `message`      | String   | Chỉ ra chi tiết trạng thái.         | `Success`                              |
| `totalCount`   | int      | Tổng số bản ghi được trả về.        | `2`                                    |
| `items`        | Array    | Danh sách các danh mục được trả về. | Xem bên dưới.                          |
| `id`           | String   | Mã định danh danh mục.              | `4fa36bf4-58a9-4c08-8226-f0c355529bdb` |

|

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
    "code": "04",
    "message": "Không tìm thấy danh mục nào.",
    "totalCount": 0,
    "items": []
}
```

-   Giải thích về mã lỗi:
    | Mã | Mô tả |
    | ---- | ------ |
    | `00` | Thành công |
    | `04` | Không tìm thấy danh mục nào khớp với bộ lọc được cung cấp. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Tìm kiếm phân trang <a id="note-1"></a>

-   Sử dụng skipCount và maxResultCount để phân trang khi có nhiều kết quả.

### 4.2 Truyền tiêu đề chính xác và đầy đủ <a id="note-2"></a>

-   Đảm bảo X-API-Key và X-Partner-ID được cung cấp chính xác cho mỗi yêu cầu.

### 4.3 Kiểm tra mã lỗi <a id="note-3"></a>

-   Mã lỗi 04 có thể xảy ra nếu không tìm thấy danh mục nào khớp với bộ lọc.

### 4.4 Đảm bảo dữ liệu phù hợp <a id="note-4"></a>

-   Đảm bảo các tham số bộ lọc (codeFilter, nameFilter) được nhập chính xác để tránh lỗi.
