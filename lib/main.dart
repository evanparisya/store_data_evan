import 'package:flutter/material.dart';
import 'dart:convert';
import 'model/pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
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
  // Deklarasi State untuk menampung List objek Pizza (Langkah 19)
  List<Pizza> myPizzas = [];

  // Fungsi untuk membaca, mengkonversi, dan mengembalikan List<Pizza>
  // Signature Method diperbarui (Langkah 18)
  Future<List<Pizza>> readJsonFile() async {
    // Membaca file JSON
    String myString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/pizzalist.json');

    // Mendekode JSON string
    List pizzaMapList = jsonDecode(myString);

    // Konversi List Map ke List Objek Dart (Langkah 16)
    List<Pizza> tempPizzas = [];
    for (var pizzaMap in pizzaMapList) {
      Pizza newPizza = Pizza.fromJson(pizzaMap);
      tempPizzas.add(newPizza);
    }

    // Mengembalikan List objek Pizza (Langkah 17)
    return tempPizzas;
  }

  @override
  void initState() {
    super.initState();

    // Memanggil readJsonFile() dan memperbarui State (Langkah 20)
    readJsonFile().then((value) {
      // value adalah hasil return dari readJsonFile(), yaitu List<Pizza>
      setState(() {
        myPizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Pizza')),

      // Menampilkan Data di ListView.builder (Langkah 21)
      body: myPizzas.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Tampilkan loading
          : ListView.builder(
              itemCount: myPizzas.length,
              itemBuilder: (BuildContext context, int index) {
                final Pizza currentPizza = myPizzas[index];

                return ListTile(
                  // Menampilkan pizzaName sebagai title
                  title: Text(currentPizza.pizzaName),
                  // Menampilkan description sebagai subtitle
                  subtitle: Text(currentPizza.description),
                  // Menampilkan harga
                  trailing: Text('\$${currentPizza.price.toStringAsFixed(2)}'),
                  // Anda bisa menambahkan Image.network(currentPizza.imageUrl) di leading jika sudah ada URL yang valid
                );
              },
            ),
    );
  }
}
