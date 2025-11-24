import 'package:flutter/material.dart';
// LANGKAH 2: Lakukan Import
import 'package:path_provider/path_provider.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path Provider Demo',
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
  // LANGKAH 3: Tambahkan Variabel Path State
  String documentsPath = 'Loading...';
  String tempPath = 'Loading...';

  // LANGKAH 4: Buat Method getPaths()
  Future<void> _getPaths() async {
    // Mengambil Jalur Dokumen (Penyimpanan Permanen)
    final docDir = await getApplicationDocumentsDirectory();
    
    // Mengambil Jalur Temporer (Penyimpanan Cache)
    final tempDir = await getTemporaryDirectory();

    // Perbarui state
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  // LANGKAH 5: Panggil getPaths() di initState()
  @override
  void initState() {
    super.initState();
    _getPaths();
  }

  // LANGKAH 6: Perbarui Tampilan (body)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Path Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Menampilkan Jalur Dokumen
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jalur Dokumen (Permanen):', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(documentsPath),
                ],
              ),
            ),
            
            // Menampilkan Jalur Temporer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jalur Temporer (Cache):', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(tempPath),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}