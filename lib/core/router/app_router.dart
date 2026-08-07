import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../provider/auth_provider.dart';
import '../../screens/auth_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/products_details_screen.dart';
import '../../screens/cart_screen.dart';
import '../../screens/profile_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // Watch the auth state (true if logged in, false otherwise)
  final isLoggedIn = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';

      // If not logged in and trying to access protected pages, send to login
      if (!isLoggedIn && !isLoggingIn) return '/login';

      // If logged in and trying to go to login, send to home
      if (isLoggedIn && isLoggingIn) return '/home';

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const AuthScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final productId = state.extra as int;
          return ProductDetailsScreen(productId: productId);
        },
      ),
      GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});
