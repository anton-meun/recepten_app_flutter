import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authProvider = StateNotifierProvider<AuthProvider, String?>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<String?> {
  AuthProvider() : super(null);

  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:5223/api"));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Registration
  Future<void> register(String firstName, String lastName, String email, String password) async {
    try {
      final response = await _dio.post('/User/register', data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        await login(email, password); // Automatically log in after registration
      }
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  // ✅ Inloggen
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await _storage.write(key: "auth_token", value: token);

        state = token; // Safe token
        return true;
      }
      return false;
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }

  // check tokon
  Future<void> checkToken() async {
    final token = await _storage.read(key: "auth_token");
    state = token; // ✅ Zet token in provider
  }

  // log off
  Future<void> logout() async {
    await _storage.delete(key: "auth_token");
    state = null;
  }
}
