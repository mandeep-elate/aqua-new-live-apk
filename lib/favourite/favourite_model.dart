class FavoriteItem {
   int id;
  final String name;
  final String sku;
  final String price;
  final String imageUrl;

  FavoriteItem({required this.id, required this.name, required this.sku,required this.price,required this.imageUrl,});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku' : sku,
      'price' : price,
      'imageUrl': imageUrl,
    };
  }

  static FavoriteItem fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      sku: json['sku'],
      price: json['price'],
    );
  }
}
