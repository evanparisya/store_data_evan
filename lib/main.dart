import 'package:flutter/material.dart';
// LANGKAH 3: Import shared_preferences
import 'package:shared_preferences/shared_preferences.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Counter',
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
  // LANGKAH 4: Variabel appCounter
  int appCounter = 0;

  // LANGKAH 5-10: Memuat, Menambah, dan Menyimpan Hitungan
  Future<void> _loadAndIncrementCounter() async {
    // LANGKAH 6: Dapatkan Instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // LANGKAH 7: Baca, Cek Null, dan Increment
    // Gunakan 'appCounter' sebagai kunci, default 0 jika null
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;

    // LANGKAH 8: Simpan Nilai Baru
    await prefs.setInt('appCounter', appCounter);

    // LANGKAH 9: Perbarui State
    setState(() {});
  }

  // LANGKAH 13: Buat Method deletePreference()
  Future<void> _deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Menghapus SEMUA data dari shared_preferences untuk aplikasi ini
    await prefs.clear();

    // Perbarui variabel dan State agar tampilan langsung berubah
    setState(() {
      appCounter = 0;
    });
  }

  // LANGKAH 10: Panggil di initState()
  @override
  void initState() {
    super.initState();
    // Memuat dan menambah hitungan saat aplikasi dibuka
    _loadAndIncrementCounter();
  }

  // LANGKAH 11: Perbarui Tampilan (body)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Penghitung')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Aplikasi telah dibuka sebanyak:',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            // Tampilkan hitungan
            Text(
              '$appCounter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            
            // LANGKAH 14: Hubungkan ke Tombol
            ElevatedButton(
              onPressed: _deletePreference, // Panggil fungsi clear/reset
              child: const Text('Reset Counter (Hapus Data)'),
            ),
          ],
        ),
      ),
    );
  }
}