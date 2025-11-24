const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImage = 'imageUrl';

class Pizza {
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
      id: int.tryParse(json[keyId].toString()) ?? 0,

      pizzaName: (json[keyName] != null) 
        ? json[keyName].toString() 
        : 'Tanpa Nama',

      description: (json[keyDescription] != null) 
        ? json[keyDescription].toString() 
        : 'Tidak ada deskripsi',

      price: double.tryParse(json[keyPrice].toString()) ?? 0.0,

      imageUrl: (json[keyImage] != null) 
        ? json[keyImage].toString() 
        : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}