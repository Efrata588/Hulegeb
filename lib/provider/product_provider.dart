import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import 'auth_provider.dart';

final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return await api.getProducts();
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  return ['electronics', 'jewelery', "men's clothing", "women's clothing"];
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredProductsProvider = FutureProvider<List<ProductModel>>((
  ref,
) async {
  final allProducts = await ref.watch(productsProvider.future);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  // Filter by category first
  List<ProductModel> filtered = allProducts;
  if (selectedCategory.toLowerCase() != 'all') {
    filtered = filtered
        .where(
          (p) => p.catagory.toLowerCase() == selectedCategory.toLowerCase(),
        )
        .toList();
  }

  // Filter by search query on title
  if (searchQuery.isNotEmpty) {
    filtered = filtered
        .where((p) => p.title.toLowerCase().contains(searchQuery))
        .toList();
  }

  return filtered;
});
