class MarketPlaceModel {
  final int id;
  final String image;
  final String name;
  final int price;

  MarketPlaceModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price});

  factory MarketPlaceModel.fromJson(Map<String, dynamic> json) {
    return MarketPlaceModel(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        price: json['price']);
  }
}
