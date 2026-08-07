class CartModel {
  final int id;
  final int userId;
  final String date;
  final Map<String, dynamic> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'],
    userId: json['userId'],
    date: json['date'],
    products: json['products'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'date': date,
    'products': products,
  };
}

// if needed summary model

class CartSummaryModle {
  final int id;
  final int cartId;
  final int totalItems;
  final double totalPriceBeforeTax;
  final double estimatedTax;
  final double totalPriceAfterTax;

  CartSummaryModle({
    required this.id,
    required this.cartId,
    required this.totalItems,
    required this.totalPriceBeforeTax,
    required this.estimatedTax,
    required this.totalPriceAfterTax,
  });

  // for local storage

  factory CartSummaryModle.fromJson(Map<String, dynamic> json) =>
      CartSummaryModle(
        id: json['id'],
        cartId: json['cartId'],
        totalItems: json['totalItems'],
        totalPriceBeforeTax: json['totalPriceBeforeTax'],
        estimatedTax: json['estimatedTax'],
        totalPriceAfterTax: json['totalPriceAfterTax'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cartId': cartId,
    'totalItems': totalItems,
    'totalPriceBeforeTax': totalPriceBeforeTax,
    'estimatedTax': estimatedTax,
    'totalPriceAfterTax': totalPriceAfterTax,
  };
}
