import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/networks/api_services.dart';
import '../core/storage/local_storage_service.dart';

final apiServiceProvider = Provider<ApiServices>((ref) => ApiServices());

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final api = ref.watch(apiServiceProvider);
  return AuthNotifier(api);
});

class AuthNotifier extends StateNotifier<bool> {
  final ApiServices _apiService;

  AuthNotifier(this._apiService) : super(false) {
    checkInitialAuth();
  }

  Future<void> checkInitialAuth() async {
    final token = await LocalStorageService.getToken();
    state = token != null;
  }

  Future<bool> login(String username, String password) async {
    try {
      final token = await _apiService.login(username, password);
      if (token != null) {
        await LocalStorageService.saveToken(token);
        state = true;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await LocalStorageService.deleteToken();
    state = false;
  }
}
