class CartItem {
  final int id;
  final String name;
  final String price;
  final String slug;
  final String pn;
  int quantity;
  final String image;

  CartItem( {
    required this.id,
    required this.name,
    required this.price,
    required this.slug,
    required this.pn,
    required this.image,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'slug' : slug,
      'PN': pn,
      'quantity': quantity,
      'image' : image
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      slug: json['slug'],
      pn: json['PN'],
      quantity: json['quantity'],
      image: json['image'],
    );
  }
}
