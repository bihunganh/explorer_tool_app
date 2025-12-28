# 🧭 Explorer Tool (GPS & Compass)

Ứng dụng công cụ sinh tồn kết hợp định vị **GPS** và **La bàn số**, giúp người dùng xác định toạ độ và phương hướng hiện tại.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Location](https://img.shields.io/badge/GPS-Location-green?style=for-the-badge)

## ✨ Tính năng chính

* **📍 Định vị GPS Real-time:** Hiển thị chính xác Vĩ độ (Latitude), Kinh độ (Longitude) và Độ cao (Altitude).
* **🧭 La bàn số:** Sử dụng cảm biến từ trường (Magnetometer) để chỉ hướng Bắc (North) theo thời gian thực.
* **🔐 Quản lý quyền:** Tự động kiểm tra và xin quyền truy cập vị trí (Location Permission) khi khởi động.
* **Giao diện trực quan:** Kim chỉ nam xoay mượt mà theo hướng điện thoại.

## 🛠 Công nghệ sử dụng

* **Geolocator:** (`geolocator`) Để lấy dữ liệu GPS.
* **Sensors Plus:** (`sensors_plus`) Để truy cập cảm biến từ trường.
* **Toán học:** Sử dụng hàm `atan2` và `pi` để tính góc xoay (Azimuth).

## 🚀 Cài đặt và Chạy

1.  **Cài đặt thư viện:**
    ```bash
    flutter pub get
    ```
2.  **Cấu hình AndroidManifest:**
    Đảm bảo file `AndroidManifest.xml` đã có quyền:
    ```xml
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    ```
3.  **Chạy ứng dụng:**
    ```bash
    flutter run
    ```

## 🧪 Hướng dẫn Test trên Máy Ảo (Emulator)

Do máy ảo không có GPS/Từ trường thật, cần giả lập dữ liệu:
1.  Mở **Extended Controls** (dấu 3 chấm trên Emulator).
2.  **Test GPS:** Chọn tab **Location** -> Bấm **Set Location** để gửi tọa độ giả.
3.  **Test La bàn:** Chọn **Virtual Sensors** -> **Rotate** mô hình điện thoại để thấy kim chỉ nam xoay theo.

## 👨‍💻 Tác giả
* **Họ và tên:** Lê Mạnh Hùng Anh
* **Lớp:** Lập trình Mobile - Flutter
