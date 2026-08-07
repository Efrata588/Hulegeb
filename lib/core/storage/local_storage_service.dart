import 'dart:convert';
import '../../models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _cartKey = 'cart_key';
  static const String _tokenKey = 'auth_token';
  static const String _summaryKey = 'current_cached_cart_summary';
  // static const String _cartHistoryKey='cart_history';

  //  save token to secure storage

  static Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw Exception('failed to save token $e');
    }
  }

  // get token from shared preferences

  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw Exception('failed to read token $e');
    }
  }

  // delete the token if they logout
  static Future<void> deleteToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    } catch (e) {
      throw Exception('failed to delete token $e');
    }
  }

  //save current cart

  static Future<void> saveCurrentCart(CartModel cart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cartKey, jsonEncode(cart.toJson()));
    } catch (e) {
      throw Exception('failed to save cart $e');
    }
  }

  static Future<CartModel?> loadCurrentCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? data = prefs.getString(_cartKey);
      if (data == null) return null;
      return CartModel.fromJson(jsonDecode(data));
    } catch (e) {
      throw Exception('failed to load cart $e');
    }
  }

  // save current cart summary

  static Future<void> saveSummary(CartSummaryModle summary) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_summaryKey, jsonEncode(summary.toJson()));
    } catch (e) {
      throw Exception('failed to save summary $e');
    }
  }

  //load summary
  static Future<CartSummaryModle?> loadSummary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? data = prefs.getString(_summaryKey);
      if (data == null) return null;
      return CartSummaryModle.fromJson(jsonDecode(data));
    } catch (e) {
      throw Exception('failed to load summary $e');
    }
  }
}
