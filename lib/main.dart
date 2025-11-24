import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// LANGKAH 1: Lakukan Import dart:io
import 'dart:io'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File I/O Demo',
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
  String documentsPath = 'Loading...';
  String tempPath = 'Loading...';
  
  // LANGKAH 2: Tambahkan Variabel File dan Text
  // 'late' digunakan karena myFile akan diinisialisasi di initState/getPaths
  late File myFile; 
  String fileText = 'File belum dibaca.';

  // --- Metode Penulisan dan Pembacaan File ---

  // LANGKAH 3: Buat Method writeFile()
  Future<bool> _writeFile() async {
    const String content = 'Margherita, Capricciosa, Napoli';
    try {
      // Menulis konten ke file yang sudah diinisialisasi
      await myFile.writeAsString(content); 
      return true;
    } catch (e) {
      print('Error menulis file: $e');
      return false;
    }
  }

  // LANGKAH 5: Buat Method readFile()
  Future<bool> _readFile() async {
    try {
      // Membaca konten dari file
      String fileContent = await myFile.readAsString();
      
      setState(() {
        fileText = fileContent;
      });
      return true;
    } catch (e) {
      print('Error membaca file: $e');
      // Jika file belum dibuat atau dihapus
      setState(() {
        fileText = 'Gagal membaca file. Apakah sudah ditulis?';
      });
      return false;
    }
  }
  
  // --- Metode Inisialisasi Path ---
  
  // Perubahan: Metode getPaths() kini juga menginisialisasi myFile
  Future<void> _getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
    
    // LANGKAH 4: Inisialisasi File dan Panggil writeFile()
    // Membuat objek File dengan jalur lengkap
    myFile = File('${docDir.path}/pizza.txt'); 
    
    // Menulis konten pertama kali
    await _writeFile();
  }

  // Panggil getPaths() di initState()
  @override
  void initState() {
    super.initState();
    _getPaths();
  }

  // --- Tampilan UI ---

  // LANGKAH 6: Edit build() dan Tambahkan Tombol Baca
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File I/O Flutter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Doc path: $documentsPath'),
            Text('Temp path: $tempPath'),
            
            const Divider(height: 32),
            
            ElevatedButton(
              // Panggil readFile() saat tombol ditekan
              onPressed: _readFile, 
              child: const Text('Baca Isi File (pizza.txt)'),
            ),

            const SizedBox(height: 16),
            const Text(
              'Isi File:', 
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            // Menampilkan konten yang dibaca dari file
            Text(fileText), 
          ],
        ),
      ),
    );
  }
}