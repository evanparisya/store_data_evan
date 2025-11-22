// lib/models/pizza.dart (Asumsi lokasi file model)

class Pizza {
  // Properti (Anggota) Class
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  // Constructor Standar
  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Factory Constructor 'fromJson' (Langkah 13)
  factory Pizza.fromJson(Map<String, dynamic> json) {
    // Penanganan Tipe Data: Konversi num (int/double) ke double
    final double finalPrice = (json['price'] as num).toDouble();
    
    return Pizza(
      id: json['id'] as int,
      pizzaName: json['pizzaName'] as String,
      description: json['description'] as String,
      price: finalPrice, 
      imageUrl: json['imageUrl'] as String,
    );
  }
}