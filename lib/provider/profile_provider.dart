import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_model.dart';
import 'auth_provider.dart';

final userOrderHistoryProvider = FutureProvider.autoDispose<List<CartModel>>((
  ref,
) async {
  final api = ref.watch(apiServiceProvider);
  return api.getUserCarts(1);
});
