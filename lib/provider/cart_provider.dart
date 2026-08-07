import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/local_storage_service.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartState {
  final CartModel? cart;
  final CartSummaryModle? summary;
  final bool isLoading;

  CartState({this.cart, this.summary, this.isLoading = false});

  CartState copyWith({
    CartModel? cart,
    CartSummaryModle? summary,
    bool? isLoading,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(Ref ref) : super(CartState()) {
    loadLocalCart();
  }

  Future<void> loadLocalCart() async {
    state = state.copyWith(isLoading: true);
    try {
      final savedCart = await LocalStorageService.loadCurrentCart();
      final savedSummary = await LocalStorageService.loadSummary();
      state = state.copyWith(
        cart: savedCart,
        summary: savedSummary,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  // add item & Calculate Summary locally
  void addToCart(ProductModel product, int userId) async {
    List<CartItem> currentItems = state.cart?.products ?? [];

    // Check if item already exists in cart
    final index = currentItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (index >= 0) {
      currentItems[index].quantity += 1;
    } else {
      currentItems.add(CartItem(product: product, quantity: 1));
    }

    final updatedCart = CartModel(
      id: state.cart?.id ?? 1,
      userId: userId,
      date: DateTime.now().toIso8601String(),
      products: currentItems,
    );

    final summary = _calculateSummary(updatedCart);

    // Save to local storage
    await LocalStorageService.saveCurrentCart(updatedCart);
    await LocalStorageService.saveSummary(summary);

    state = state.copyWith(cart: updatedCart, summary: summary);
  }

  void removeFromCart(int productId) async {
    if (state.cart == null) return;

    final currentItems = state.cart!.products
        .where((item) => item.product.id != productId)
        .toList();

    final updatedCart = CartModel(
      id: state.cart!.id,
      userId: state.cart!.userId,
      date: state.cart!.date,
      products: currentItems,
    );

    final summary = _calculateSummary(updatedCart);

    await LocalStorageService.saveCurrentCart(updatedCart);
    await LocalStorageService.saveSummary(summary);

    state = state.copyWith(cart: updatedCart, summary: summary);
  }

  void decreaseQuantity(int productId) async {
    if (state.cart == null) return;

    final currentItems = state.cart!.products
        .map((item) {
          if (item.product.id == productId) {
            return CartItem(product: item.product, quantity: item.quantity - 1);
          }
          return item;
        })
        .where((item) => item.quantity > 0)
        .toList();

    final updatedCart = CartModel(
      id: state.cart!.id,
      userId: state.cart!.userId,
      date: state.cart!.date,
      products: currentItems,
    );

    final summary = _calculateSummary(updatedCart);

    await LocalStorageService.saveCurrentCart(updatedCart);
    await LocalStorageService.saveSummary(summary);

    state = state.copyWith(cart: updatedCart, summary: summary);
  }

  CartSummaryModle _calculateSummary(CartModel cart) {
    int totalItems = 0;
    double totalPriceBeforeTax = 0.0;

    for (var item in cart.products) {
      totalItems += item.quantity;
      totalPriceBeforeTax += (item.product.price * item.quantity);
    }

    // Assuming a flat 10% tax rate
    double estimatedTax = totalPriceBeforeTax * 0.10;
    double totalPriceAfterTax = totalPriceBeforeTax + estimatedTax;

    return CartSummaryModle(
      id: cart.id,
      userId: cart.userId,
      totalItems: totalItems,
      totalPriceBeforeTax: totalPriceBeforeTax,
      estimatedTax: estimatedTax,
      totalPriceAfterTax: totalPriceAfterTax,
    );
  }
}

final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((
  ref,
) {
  return CartNotifier(ref);
});
