import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:recepten_app_flutter/entities/complete_recipe.dart';
import '../../api/network.dart';
import 'auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'get_favorites_provider.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {

  final Dio _dio = Dio(BaseOptions(
    baseUrl: apiUrl,
  ));

  @override
  Future<List<CompleteRecipe>> build() async {
    return [];
  }

  Future<void> addFavorite(CompleteRecipe recipe, {String comment = ""}) async {
    try {
      final token = ref.read(authProvider);
      if (token == null) throw Exception("Not authenticated");

      final response = await _dio.post(
        "/Favorite/Addfavorites",
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
        "/Favorite/Deletefavorites/$mealId",
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
