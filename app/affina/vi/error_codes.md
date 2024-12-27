# Bảng mã lỗi

## 1. Tổng quan

Bảng mã lỗi liệt kê các mã trạng thái được hệ thống API LynkiD trả về.

Mỗi mã lỗi có một ý nghĩa cụ thể, giúp các đối tác dễ dàng xác định và xử lý các sự cố phát sinh khi sử dụng API.

---

> Bảng mã lỗi

| **Mã lỗi** | **Mô tả lỗi**                                                     |
| ---------- | ----------------------------------------------------------------- |
| `00`       | Thành công                                                        |
| `100`      | Lỗi không xác định, hãy liên hệ với LynkiD để biết thêm thông tin |
| `101`      | OtpSession trùng lặp                                              |
| `102`      | PhoneNumber tạm thời bị chặn đối với OTP mới                      |
| `200`      | Mã thành viên đối tác không hợp lệ                                |
| `201`      | Không tìm thấy kết nối cho Mã thành viên đối tác                  |
| `202`      | Không đủ điểm để đổi                                              |
| `203`      | Quà tặng hết hàng                                                 |
| `204`      | Mã quà tặng không hợp lệ                                          |
| `300`      | LevelFilter hoặc parentCodeFilter không hợp lệ                    |
| `301`      | Không tìm thấy dữ liệu cho các bộ lọc được cung cấp               |

---

## 2. Lưu ý

-   **Mã lỗi `00`**:
-   Thành công, không xảy ra lỗi. Phản hồi sẽ trả về dữ liệu tương ứng.
-   **Mã lỗi `100`**:
-   Lỗi không xác định, vui lòng liên hệ với nhóm hỗ trợ LynkiD để biết thêm chi tiết.
-   **Mã lỗi khác**:
-   Những mã này được sử dụng để chỉ ra các lỗi cụ thể liên quan đến quy trình kết nối, đổi quà tặng hoặc truy vấn dữ liệu.

---

## 3. Hướng dẫn xử lý lỗi

1. **Mã lỗi `100` (Lỗi không xác định)**:

-   Liên hệ với nhóm hỗ trợ LynkiD qua email hoặc đường dây nóng để biết thêm thông tin.

2. **Lỗi kết nối (`200`, `201`)**:

-   Đảm bảo rằng `partnerMemberCode` được cung cấp là hợp lệ và kết nối được thiết lập đúng cách.

3. **Lỗi đổi quà tặng (`202`, `203`, `204`)**:

-   Kiểm tra điểm của thành viên, tính hợp lệ của mã quà tặng (`giftCode`) và tình trạng còn hàng.

4. **Lỗi truy vấn dữ liệu (`300`, `301`)**:

-   Đảm bảo rằng tất cả các tham số lọc (`levelFilter`, `parentCodeFilter`, v.v.) được cung cấp chính xác và đầy đủ.

---

## 4. Cập nhật mã lỗi trong tương lai

-   **Mã lỗi bổ sung**:
-   Sẽ có thêm các mã lỗi liên quan đến:
-   Kết nối thành viên.
-   Quy trình đổi quà tặng.
-   Kiểm tra trạng thái kết nối trước khi truy vấn dữ liệu.

---

## 5. Liên hệ Hỗ trợ

Nếu bạn cần thêm thông tin hoặc hỗ trợ khi gặp lỗi, vui lòng liên hệ với nhóm hỗ trợ LynkiD:

-   **Email**: support@lynkid.vn
-   **Hotline**: 1900-8386
