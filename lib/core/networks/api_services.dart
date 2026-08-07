import 'package:dio/dio.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  //Auth

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      }
      return null;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  //Products//

  //-----fetch all products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      return (response.data)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products:$e');
    }
  }

  //-----get product by id

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product:$e');
    }
  }

  //-----serch products by title---i think this is done in the provider

  //cart//

  //----get all carts for id allocation purpose
  Future<List<CartModel>> getAllCarts() async {
    try {
      final response = await _dio.get('/carts');
      return (response.data).map((json) => CartModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load carts:$e');
    }
  }

  //----create cart for first time users only

  Future<CartModel> createCart(int userId) async {
    final carts = await getAllCarts();
    final cartId = carts.length + 1;

    final CartModel cart = CartModel(
      id: cartId,
      userId: userId,
      date: DateTime.now().toString(),
      products: [],
    );
    try {
      final response = await _dio.post('/carts', data: cart.toJson());
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create cart:$e');
    }
  }

  ///list of carts associated with each customer/user

  Future<List<CartModel>> getUserCarts(int userId) async {
    try {
      final response = await _dio.get('/carts/user/$userId');

      return (response.data as List)
          .map((json) => CartModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch user carts: $e');
    }
  }

  //------update cart

  Future<CartModel> updateCart(
    int cartId,
    Map<String, dynamic> cartData,
  ) async {
    try {
      final response = await _dio.put('/carts/$cartId', data: cartData);
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update cart: $e');
    }
  }

  ///users

  Future<UserModel> getUserProfile(int userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  // 8. Update user profile (username, name, phone, etc.)
  Future<UserModel> updateUserProfile(
    int userId,
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await _dio.put('/users/$userId', data: userData);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }
}
