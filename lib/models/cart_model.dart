class CartModel {
  final int id;
  final int item;
  final int quantity;
  final String image;
  final String name;
  final String price;
  final String description;

  CartModel({
    required this.id,
    required this.item,
    required this.quantity,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  factory CartModel.fromJson(Map<String, dynamic> json){
    return CartModel(
      id: json['id'],
      item: json['item'],
      quantity: json['quantity'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}
