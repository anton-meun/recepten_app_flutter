import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:recepten_app_flutter/entities/complete_recipe.dart';
import 'auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'get_favorites_serves.dart';

part 'favorites_serves.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:5223/api"));

  @override
  Future<List<CompleteRecipe>> build() async {
    return [];
  }

  Future<void> addFavorite(CompleteRecipe recipe, {String comment = ""}) async {
    try {
      final token = ref.read(authProvider);
      if (token == null) throw Exception("Not authenticated");

      final response = await _dio.post(
        "/user/favorites",
        data: {"mealId": recipe.id, "comment": comment},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        print("Favorite added successfully!");

        await ref.read(favoritesFetcherProvider.notifier).resetFavorites();
      }
    } catch (e) {
      print("Error occurred while adding favorite: $e");
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> removeFavorite(dynamic mealId) async {
    int id = int.tryParse(mealId.toString()) ?? 0;
    try {
      final token = ref.read(authProvider);
      if (token == null) throw Exception("Not authenticated");

      final response = await _dio.delete(
        "/user/favorites/$mealId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        print("Favorite removed successfully!");

        await ref.read(favoritesFetcherProvider.notifier).resetFavorites();
      }
    } catch (e) {
      print("Error occurred while removing favorite: $e");
      state = AsyncError(e, StackTrace.current);
    }
  }

}
