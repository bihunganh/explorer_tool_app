import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

class ExplorerTool extends StatefulWidget {
  const ExplorerTool({super.key});

  @override
  State<ExplorerTool> createState() => _ExplorerToolState();
}

class _ExplorerToolState extends State<ExplorerTool> {
  String _locationMessage = "Đang lấy vị trí...";

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // Hàm xin quyền và lấy vị trí
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Kiểm tra GPS Hardware có bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() => _locationMessage = "Hãy bật GPS (Location Service)!");
      }
      return;
    }

    // 2. Kiểm tra quyền của Ứng dụng
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() => _locationMessage = "Quyền vị trí bị từ chối.");
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() => _locationMessage = "Quyền bị từ chối vĩnh viễn. Hãy vào cài đặt để mở lại.");
      }
      return;
    }

    // 3. Lấy tọa độ hiện tại (High Accuracy dùng GPS)
    // Lưu ý: Trên máy ảo, bạn phải set tọa độ thủ công thì hàm này mới trả về kết quả nhanh.
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
    );

    if (mounted) {
      setState(() {
        _locationMessage =
        "Vĩ độ (Lat): ${position.latitude}\nKinh độ (Long): ${position.longitude}\nĐộ cao (Alt): ${position.altitude.toStringAsFixed(1)}m";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Explorer Tool", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Phần 1: Hiển thị GPS
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.blueGrey[900],
            child: Text(
              _locationMessage,
              style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontFamily: 'monospace'),
              textAlign: TextAlign.center,
            ),
          ),

          // Phần 2: La bàn (Magnetometer)
          Expanded(
            child: StreamBuilder<MagnetometerEvent>(
              stream: magnetometerEventStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final event = snapshot.data!;
                // Tính góc hướng bắc (Azimuth) dùng hàm atan2
                // Lưu ý: Công thức này đúng khi để điện thoại nằm ngang (flat)
                double heading = atan2(event.y, event.x); // Kết quả là Radian

                // Chuyển sang độ
                double headingDegrees = heading * 180 / pi;
                if (headingDegrees < 0) headingDegrees += 360;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${headingDegrees.toStringAsFixed(0)}°",
                          style: const TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                      const Text("HƯỚNG BẮC", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),

                      // Xoay icon để chỉ hướng
                      Transform.rotate(
                        angle: -heading - (pi / 2), // Điều chỉnh góc xoay cho khớp với icon Navigation
                        child: const Icon(Icons.navigation, size: 150, color: Colors.redAccent),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}