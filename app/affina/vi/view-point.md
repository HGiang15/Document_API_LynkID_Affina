# API Truy vấn Điểm LynkiD

API này cho phép các đối tác truy vấn số dư điểm của thành viên từ hệ thống LynkiD.
Khi gọi API, bạn cần cung cấp **mã thành viên đối tác** (partnerMemberCode) để lấy thông tin số dư và ví LynkiD.

---

## Mục lục

1. [Chi tiết API](#api-details)
    - [Tiêu đề](#headers)
    - [Tham số truy vấn](#query-params)
2. [Yêu cầu mẫu](#request)
3. [Phản hồi mẫu](#response)
    - [Trường hợp thành công](#success)
    - [Trường hợp thất bại](#failure)
4. [Ghi chú](#note)
    - [Truyền tiêu đề chính xác](#note-1)
    - [Kiểm tra phản hồi](#note-2)
    - [Định dạng dữ liệu](#note-3)
    - [Bảo mật](#note-4)

## 1. Chi tiết API <a id="api-details"></a>

-   **Điểm cuối**: `/affina/view-point`
-   **Phương thức**: `GET`
-   **Định dạng dữ liệu**: JSON

### 1.1. Tiêu đề <a id="headers"></a>

| Tên tiêu đề    | Kiểu  | Bắt buộc | Mô tả                                     |
| -------------- | ----- | -------- | ----------------------------------------- |
| `X-API-Key`    | Chuỗi | Có       | Mã định danh khóa API do LynkiD cung cấp. |
| `X-Partner-ID` | Chuỗi | Có       | Mã định danh đối tác do LynkiD cung cấp.  |

### 1.2. Tham số truy vấn <a id="query-params"></a>

#### Chuỗi truy vấn yêu cầu

| Tên tham số         | Kiểu   | Bắt buộc | Mô tả                                | Ví dụ        |
| ------------------- | ------ | -------- | ------------------------------------ | ------------ |
| `partnerMemberCode` | String | Có       | Mã định danh thành viên của đối tác. | `AFCODE0001` |

---

## 2. Yêu cầu mẫu <a id="request"></a>

```http
[rootURL]/affina/view-point?partnerMemberCode=AFCODE0001 HTTP/1.1
Host: [BASE_URL]
X-API-Key: YOUR_API_KEY
X-Partner-ID: YOUR_PARTNER_ID
```

## 3. Phản hồi mẫu <a id="response"></a>

### 3.1. Trường hợp thành công <a id="success"></a>

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

-   Giải thích về các trường phản hồi
    | Tên trường | Kiểu | Mô tả | Ví dụ |
    | ------------------- | ------ |--------------------------------------- | ------------ |
    | `code` | String | Chỉ ra trạng thái của phản hồi. | `00` |
    | `message` | String | Chỉ ra chi tiết trạng thái. | `Thành công` |
    | `partnerMemberCode` | String | Mã định danh thành viên của đối tác. | `P_MemberCode_01` |
    | `lynkiDWallet` | String | Địa chỉ ví của khách hàng trên LynkiD. | `f8e1facb995f0e2cf9eaebab95ce62f273fc07` |
    | `balance` | Decimal | Số dư hiện tại của khách hàng trên LynkiD. | `1000000` |
    | `expiringBalance` | Decimal | Có thể để giá trị Null. Nếu dữ liệu tồn tại, dữ liệu đó biểu thị số dư hết hạn của thành viên. | `12000` |

### 3.2. Trường hợp lỗi <a id="failure"></a>

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

-   Giải thích về mã lỗi:
    | Tên trường | Loại |
    | ---------- | ------ |
    | `00` | Thành công |
    | `04` | Thành viên không được kết nối với tài khoản LynkiD. |

## 4. Lưu ý <a id="note"></a>

### 4.1 Truyền tiêu đề chính xác và đầy đủ <a id="note-1"></a>

-   Cần có X-API-Key và X-Partner-ID cho mọi yêu cầu.

### 4.2 Kiểm tra Phản hồi <a id="note-2"></a>

-   Kiểm tra các trường mã và thông báo trong phản hồi để xác định trạng thái.

### 4.3 Định dạng dữ liệu <a id="note-3"></a>

-   Đảm bảo rằng yêu cầu sử dụng định dạng JSON khi cần thiết (trong các API khác).

### 4.4 Bảo mật <a id="note-4"></a>

-   Cặp X-API-Key và X-Partner-ID là duy nhất cho mỗi đối tác và không được chia sẻ công khai.
