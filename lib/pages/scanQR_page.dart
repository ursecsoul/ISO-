// ignore: file_names
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (BarcodeCapture capture) {
              if (_scanned) return;
              final String? code = capture.barcodes.first.rawValue;

              if (code != null) {
                setState(() {
                  _scanned = true;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('QR Code: $code')),
                );

                Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                    _scanned = false;
                  });
                });
              }
            },
          ),
          if (_scanned)
            const Center(
              child: Icon(Icons.check_circle, color: Colors.green, size: 100),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            // Stay on the same page
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xFF009640),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
