import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String? qrRawValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background scanner
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: true,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                print('Barcode detected: ${barcode.rawValue}');
                setState(() {
                  qrRawValue = barcode.rawValue;
                });
              }
              if (image != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(qrRawValue ?? "No reference found from this QR code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.memory(image),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (qrRawValue != null) {
                                Share.share(qrRawValue!);
                              }
                            },
                            child: Text('Share QR Code'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),

          // Overlay UI
          Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    Text(
                      'Scan QR Code',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        if (qrRawValue != null) {
                          Share.share(qrRawValue!);
                        }
                      },
                      icon: Icon(Icons.share, color: Colors.white),
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Scanner frame
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              Spacer(),

              // Slider
              Slider(
                value: 1.0,
                min: 0.5,
                max: 2.0,
                divisions: 3,
                activeColor: Colors.white,
                onChanged: (value) {
                  // Handle zoom adjustment here
                },
              ),

              // Bottom buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/generator');
                      },
                      icon: Icon(Icons.qr_code_2),
                      label: Text('Generate'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0C74F6),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle history button
                      },
                      icon: Icon(Icons.history),
                      label: Text('History'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}