import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0), // Jarak dari sisi kiri
          child: Expanded(
            child: Image.asset(
              'assets/images/instaScan_logo.png',
              fit: BoxFit.contain, // Menyesuaikan ukuran gambar agar tetap proporsional
              width: 167.9,
              height: 44,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0), // Jarak dari sisi kanan
            child: Container(
              padding: const EdgeInsets.all(8.0), // Memberi jarak sekitar ikon
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Warna latar belakang lingkaran
                shape: BoxShape.circle, // Bentuk lingkaran
              ),
              child: IconButton(
                icon: const Icon(Icons.notification_add_outlined,
                    color: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Notification setting clicked')));
                },
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Grid menu
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                      icon: Icons.qr_code_scanner,
                      title: 'Scan',
                      subtitle: 'Documents, ID card...',
                      color: const Color(0xFFFB8931),
                      onTap: () {
                        Navigator.pushNamed(context, '/scanner');
                      }),
                  _buildMenuCard(
                    icon: Icons.qr_code,
                    title: 'Generator code',
                    subtitle: 'Code, Add Text...',
                    color: const Color(0xFF0C74F6),
                    onTap: () {
                      Navigator.pushNamed(context, '/generator');
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.file_copy,
                    title: 'Convert',
                    subtitle: 'pdf, jpg, doc...',
                    color: const Color(0xFFE45475),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('This fiture will be work soon!')));
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.psychology,
                    title: 'Ask AI',
                    subtitle: 'Summarize, Rewrite...',
                    color: const Color(0xFF7E5FFA),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('This fiture will be work soon!')));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Indeks item yang dipilih saat ini
        onTap: (index) {
          // Tambahkan fungsi untuk menangani perubahan tab
        },
        backgroundColor:
            Colors.white, // Warna latar belakang BottomNavigationBar
        selectedItemColor:
            Color(0xFF0C74F6), // Warna ikon & label item yang dipilih
        unselectedItemColor:
            Colors.grey, // Warna ikon & label item yang tidak dipilih
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(16), // memberi jarak sekitar icon
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Warna latar belakang lingkaran
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
                child: Icon(icon, size: 40, color: Colors.black)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
