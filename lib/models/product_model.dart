class ProductModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final Map<String, dynamic> rating;
  final String description;
  final String catagory;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.description,
    required this.catagory,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    price: (json["price"] as num).toDouble(),
    image: json["image"],
    rating: Map<String, dynamic>.from(json["rating"] ?? {}),
    description: json["description"],
    catagory: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "image": image,
    "rating": rating,
    "description": description,
    "category": catagory,
  };
}
