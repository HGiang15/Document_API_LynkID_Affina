# API Lấy danh sách Thành phố, Quận, Phường

API này cho phép truy vấn các cấp hành chính (Thành phố, Quận, Phường) trong hệ thống. Người dùng có thể lọc dữ liệu theo cấp hành chính, mã cha, tên, mã hoặc ID và sử dụng phân trang để tối ưu hóa kết quả.

---

## Mục lục

1. [Chi tiết API](#api-details)
    - [Tiêu đề](#headers)
    - [Chuỗi truy vấn yêu cầu](#query-params)
2. [Yêu cầu mẫu](#request)
3. [Phản hồi mẫu](#response)
    - [Trường hợp thành công](#success)
    - [Trường hợp thất bại](#failure)
4. [Ghi chú](#note)
    - [Phân trang](#note-1)
    - [Đầu vào hợp lệ](#note-2)
    - [Tìm kiếm theo cấp độ cha](#note-3)

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/get-city-district-ward`
-   **Phương thức**: `GET`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu   | Bắt buộc | Mô tả                          |
| -------------- | ------ | -------- | ------------------------------ |
| `X-API-Key`    | String | Có       | Khóa API do LynkiD cung cấp.   |
| `X-Partner-ID` | String | Có       | ID đối tác do LynkiD cung cấp. |

### 1.2. Tham số truy vấn <a id="query-params"></a>

#### Chuỗi truy vấn yêu cầu

| Tên tham số        | Kiểu   | Bắt buộc | Mô tả                                                     | Ví dụ          |
| ------------------ | ------ | -------- | --------------------------------------------------------- | -------------- |
| `levelFilter`      | String | Có       | Cấp quản trị để truy vấn (`Thành phố`, `Quận`, `Phường`). | `"Thành phố"`  |
| `codeFilter`       | String | Không    | Lọc theo mã quản trị.                                     | `"66"`         |
| `parentCodeFilter` | String | Có       | Mã cha của cấp quản trị hiện tại.                         | `"Tiếng Việt"` |
| `nameFilter`       | String | Không    | Lọc theo tên.                                             | `"An Giang"`   |
| `idFilter`         | int    | Không    | Lọc theo ID.                                              | `30829`        |
| `skipCount`        | int    | Có       | Tham số phân trang, mặc định là 0.                        | `0`            |
| `maxResultCount`   | int    | Có       | Tham số phân trang, mặc định là 10.                       | `10`           |

---

## 2. Ví dụ về yêu cầu <a id="request"></a>

```http
[rootURL]/affina/get-city-district-ward?levelFilter=City&parentCodeFilter=Vietnamese&skipCount=0&maxResultCount=10 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Ví dụ về phản hồi <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

> Khi truy vấn với `levelFilter = City`

```json
{
    "totalCount": 64,
    "items": [
        {
            "id": 30829,
            "code": "66",
            "name": "An Giang",
            "description": "City",
            "parentCode": "Tiếng Việt",
            "internalCode": "66",
            "level": "City"
        },
        {
            "id": 30830,
            "code": "67",
            "name": "Bà Rịa - Vũng Tàu",
            "description": "City",
            "parentCode": "Tiếng Việt",
            "internalCode": "67",
            "level": "City"
        },
        {
            "id": 30831,
            "code": "81",
            "name": "Bắc Cạn",
            "description": "Thành phố",
            "parentCode": "Tiếng Việt",
            "internalCode": "81",
            "level": "Thành phố"
        },

        {
            "id": 30883,
            "code": "48",
            "name": "Quảng Trị",
            "description": "Thành phố",
            "parentCode": "Tiếng Việt",
            "internalCode": "48",
            "level": "Thành phố"
        }
    ],
    "code": "00",
    "message": null
}
```

-   Mô tả trường phản hồi

| Tên trường | Kiểu  | Mô tả                                             | Ví dụ                  |
| ---------- | ----- | ------------------------------------------------- | ---------------------- |
| totalCount | int   | Tổng số bản ghi tìm thấy.                         | 64                     |
| mục        | Array | Danh sách đơn vị hành chính.                      | Xem chi tiết bên dưới. |
| mã         | Chuỗi | Mã trạng thái phản hồi. "00" biểu thị thành công. | "00"                   |
| thông báo  | Chuỗi | Thông báo lỗi chi tiết nếu có.                    | null                   |

---

-   ​​Các trường bên trong `items`

| Tên trường   | Kiểu   | Mô tả                                             | Ví dụ        |
| ------------ | ------ | ------------------------------------------------- | ------------ |
| id           | int    | ID của đơn vị hành chính trong hệ thống.          | 30829        |
| mã           | String | Mã đơn vị hành chính.                             | "66"         |
| tên          | String | Tên đơn vị hành chính.                            | "An Giang"   |
| mô tả        | String | Loại đơn vị hành chính (Thành phố, Quận, Phường). | "Thành phố"  |
| parentCode   | String | Mã cha của cấp hành chính hiện tại.               | "Tiếng Việt" |
| internalCode | String | Mã nội bộ của đơn vị hành chính.                  | "66"         |
| level        | String | Cấp hành chính (Thành phố, Quận, Phường).         | "Thành phố"  |

### 3.2. Trường hợp lỗi <a id="failure"></a>

```json
{
    "code": "1027",
    "message": "levelFilter hoặc parentCodeFilter không hợp lệ"
}
```

-   Mô tả mã lỗi:
    | Mã | Mô tả |
    | ---------- | ------ |
    | `00` | Thành công, trả về danh sách các cấp hành chính. |
    | `1027` | levelFilter hoặc parentCodeFilter không hợp lệ. |

## 4. Ghi chú <a id="note"></a>

### 4.1 Phân trang <a id="note-1"></a>

-   Sử dụng skipCount và maxResultCount để truy xuất dữ liệu được phân trang.

### 4.2 Đầu vào hợp lệ <a id="note-2"></a>

-   `levelFilter` và `parentCodeFilter` là bắt buộc. Đảm bảo đầu vào chính xác để tránh lỗi.

### 4.3 Tìm kiếm theo Cấp độ phụ huynh <a id="note-3"></a>

-   Khi tìm kiếm Quận, hãy cung cấp mã Thành phố làm parentCodeFilter. Tương tự, đối với Phường, hãy cung cấp mã Quận.
