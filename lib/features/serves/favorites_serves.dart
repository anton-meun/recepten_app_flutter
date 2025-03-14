import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:recepten_app_flutter/entities/complete_recipe.dart';
import 'auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

      print("Adding favorite: ${recipe.name}");

      final response = await _dio.post(
        "/user/favorites",
        // Je API-endpoint voor het toevoegen van een favoriet
        data: {
          "mealId": recipe.id,
          "comment": comment, // Het commentaar wordt hier meegegeven
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        print("Favorite added successfully!");
        state = AsyncData([...state.value ?? [], recipe]);
      } else {
        print("Failed to add favorite. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while adding favorite: $e");
      state = AsyncError(e, StackTrace.current);
    }
  }
}
