import 'package:hulegeb/models/product_model.dart';

class CartModel {
  final int id;
  final int userId;
  final String date;
  final List<CartItem> products;

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
    products: (json['products'] as List)
        .map((product) => CartItem.fromJson(product))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'date': date,
    'products': products,
  };
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

// if needed summary model

class CartSummaryModle {
  final int id;
  final int userId;
  final int totalItems;
  final double totalPriceBeforeTax;
  final double estimatedTax;
  final double totalPriceAfterTax;

  CartSummaryModle({
    required this.id,
    required this.userId,
    required this.totalItems,
    required this.totalPriceBeforeTax,
    required this.estimatedTax,
    required this.totalPriceAfterTax,
  });

  // for local storage

  factory CartSummaryModle.fromJson(Map<String, dynamic> json) =>
      CartSummaryModle(
        id: json['id'],
        userId: json['userId'], // Fixed from 'cartId'
        totalItems: json['totalItems'],
        totalPriceBeforeTax: (json['totalPriceBeforeTax'] as num).toDouble(),
        estimatedTax: (json['estimatedTax'] as num).toDouble(),
        totalPriceAfterTax: (json['totalPriceAfterTax'] as num).toDouble(),
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'cartId': userId,
    'totalItems': totalItems,
    'totalPriceBeforeTax': totalPriceBeforeTax,
    'estimatedTax': estimatedTax,
    'totalPriceAfterTax': totalPriceAfterTax,
  };
}
