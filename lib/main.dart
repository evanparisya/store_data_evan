import 'package:flutter/material.dart';
// LANGKAH 2: Lakukan Import package flutter_secure_storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
// import dart:io, path_provider, dll. tidak diperlukan untuk secure storage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Storage Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // LANGKAH 3: Tambahkan Variabel dan Controller
  final TextEditingController pwdController = TextEditingController();
  String myPass = ''; // Variabel untuk menampung data yang dibaca

  // LANGKAH 4: Inisialisasi Secure Storage dan Kunci
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String keyMyKey = 'myPass'; // Kunci penyimpanan data

  // LANGKAH 5: Buat Method writeToSecureStorage()
  Future<void> _writeToSecureStorage() async {
    // Menulis data dari TextField ke penyimpanan aman
    await storage.write(
      key: keyMyKey,
      value: pwdController.text,
    );
    // Tampilkan notifikasi
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nilai berhasil disimpan secara aman!')),
      );
    }
  }

  // LANGKAH 6: Buat Method readFromSecureStorage()
  Future<String> _readFromSecureStorage() async {
    // Membaca data menggunakan kunci
    String? secret = await storage.read(key: keyMyKey);
    // Jika data null (belum ada), kembalikan string kosong
    return secret ?? '<< Tidak ada data tersimpan >>'; 
  }

  // --- Tampilan UI dan Logika ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Secure Storage')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // LANGKAH 7: Tampilkan TextField untuk input kata sandi
            TextField(
              controller: pwdController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nilai Rahasia (Password/Token)',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            
            // Tombol "Save Value"
            ElevatedButton(
              onPressed: _writeToSecureStorage, 
              child: const Text('Save Value (Tulis ke Secure Storage)'),
            ),
            const SizedBox(height: 20),
            
            // Tombol "Read Value"
            // LANGKAH 8: Hubungkan Read ke Tombol dan Perbarui State
            ElevatedButton(
              onPressed: () {
                _readFromSecureStorage().then((value) {
                  setState(() {
                    myPass = value; // Perbarui state myPass
                  });
                });
              },
              child: const Text('Read Value (Baca dari Secure Storage)'),
            ),
            
            const Divider(height: 40),
            
            // Tampilkan hasil pembacaan
            const Text(
              'Nilai Terenkripsi yang Dibaca:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              myPass,
              style: const TextStyle(fontFamily: 'monospace', color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}