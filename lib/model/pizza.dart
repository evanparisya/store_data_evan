class Pizza {
  // Properti (Anggota) Class
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;


  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: int.tryParse(json['id'].toString()) ?? 0,

      pizzaName: (json['pizzaName'] != null) 
        ? json['pizzaName'].toString() 
        : 'Tanpa Nama',

      description: (json['description'] != null) 
        ? json['description'].toString() 
        : 'Tidak ada deskripsi',

      price: double.tryParse(json['price'].toString()) ?? 0.0,

      imageUrl: (json['imageUrl'] != null) 
        ? json['imageUrl'].toString() 
        : '',
    );
  }
}