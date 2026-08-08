import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';
import '../provider/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authNotifierProvider);
    final orderHistoryAsync = ref.watch(userOrderHistoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE4E4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF98080B),
        title: const Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF98080B),
                    child: Text(
                      'J',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'john@gmail.com',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isLoggedIn
                            ? 'Auth Status: Authenticated'
                            : 'Auth Status: Guest',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isLoggedIn ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.shopping_bag, color: Color(0xFF98080B)),
                    title: Text('Order History'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                  const Divider(),
                  orderHistoryAsync.when(
                    data: (carts) {
                      if (carts.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('No orders found.'),
                        );
                      }
                      return Column(
                        children: carts.map((cart) {
                          return ListTile(
                            leading: const Icon(
                              Icons.receipt_long,
                              color: Color(0xFF98080B),
                            ),
                            title: Text('Cart #${cart.id}'),
                            subtitle: Text(
                              '${cart.products.length} item(s) • ${cart.date.split('T').first}',
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(),
                    ),
                    error: (err, stack) => Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Failed to load orders: $err'),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.location_on, color: Color(0xFF98080B)),
                    title: Text('Shipping Address'),
                    subtitle: Text('123 Main St, New York'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () async {
                      await ref.read(authNotifierProvider.notifier).logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
