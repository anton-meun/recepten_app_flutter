import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recepten_app_flutter/features/providers/auth_provider.dart';

Future<void> logout(BuildContext context, WidgetRef ref) async {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  await _storage.delete(key: "auth_token");

  ref.read(authProvider.notifier).state = null;

  Navigator.pushReplacementNamed(context, '/login');
}
