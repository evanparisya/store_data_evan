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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
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
  List<Pizza> myPizzas = [];

  // Fungsi untuk membaca dan mengkonversi JSON
  Future<List<Pizza>> readJsonFile() async {
    // Membaca file JSON dari assets
    String myString = await DefaultAssetBundle.of(context).loadString('assets/pizzalist.json');

    // Mendekode JSON string menjadi List Map
    List pizzaMapList = jsonDecode(myString);

    // Konversi List Map ke List Objek Pizza menggunakan fromJson yang robust
    List<Pizza> tempPizzas = [];
    for (var pizzaMap in pizzaMapList) {
      Pizza newPizza = Pizza.fromJson(pizzaMap);
      tempPizzas.add(newPizza);
    }

    return tempPizzas;
  }

  @override
  void initState() {
    super.initState();
    // Memuat data saat aplikasi dimulai dan memperbarui State
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pizza Anti-Crash'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: myPizzas.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Tampilan Loading
          : ListView.builder(
              itemCount: myPizzas.length,
              itemBuilder: (BuildContext context, int index) {
                final Pizza currentPizza = myPizzas[index];

                return ListTile(
                  leading: const Icon(Icons.local_pizza, color: Colors.red),
                  title: Text(
                    currentPizza.pizzaName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(currentPizza.description),
                  trailing: Text(
                    '\$${currentPizza.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}