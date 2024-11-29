import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String? qrRawValue;
  final ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C74F6),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Generate QR Code',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey[100], // Warna latar belakang soft grey
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Input Field
            Column(
              children: [
                const Text(
                  'Enter the data to generate your QR Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      qrRawValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter text or link...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.text_fields, color: Colors.grey),
                  ),
                ),
              ],
            ),
      
            // QR Code Display
            if (qrRawValue != null)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Screenshot(
                      controller: screenshotController, // controler ss for QR
                      child: PrettyQr(
                        data: qrRawValue!,
                        size: 200,
                        elementColor: const Color(0xFF0C74F6),
                        roundEdges: true,
                      ),
                    )
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _shareQrCode();
                    },
                    icon: const Icon(Icons.share),
                    label: const Text("Share QR Code"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C74F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "No QR Code generated yet!",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
      
            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/scanner');
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text("Scan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C74F6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      qrRawValue = null; // Clear the QR code
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareQrCode() async {
    // ambil screenshot dari QR
    final image = await screenshotController.capture();
    if (image != null) {
      // kalau berhasil ambil gambar, share menggunakan Share Plus
      await Share.shareXFiles([
        XFile.fromData(
          image,
          name: "qr_code.png", // nama file screenshot
          mimeType: "image/png", // format file
        ),
      ]);
    }
  }
}
