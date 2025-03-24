import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../api/network.dart';
import 'auth_provider.dart';
import '../../entities/complete_recipe.dart';
import '../../entities/favorite_recipe.dart';

part 'get_favorites_provider.g.dart';

@riverpod
class FavoritesFetcher extends _$FavoritesFetcher {

  final Dio _dio = Dio(BaseOptions(
    baseUrl: apiUrl,
  ));

  @override
  Future<List<FavoriteRecipe>> build() async {
    return [];
  }


  Future<void> getFavorites() async {
    try {
      final token = ref.read(authProvider);
      if (token == null) throw Exception("Not authenticated");

      final response = await _dio.get(
        "/Favorite/Getfavorites",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        List<dynamic> favoritesData = response.data;

        List<FavoriteRecipe> favoriteRecipes = [];

        for (var fav in favoritesData) {
          final mealId = fav['mealId'];
          final comment = fav['comment'];

          final mealResponse = await Dio().get(
            "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId",
          );

          if (mealResponse.statusCode == 200 && mealResponse.data['meals'] != null) {
            var mealData = mealResponse.data['meals'][0];

            var recipe = CompleteRecipe.fromMap(mealData);


            var favoriteRecipe = FavoriteRecipe(recipe: recipe, comment: comment);

            favoriteRecipes.add(favoriteRecipe);
          }
        }

        state = AsyncData(favoriteRecipes);
      } else {
        throw Exception("Failed to load favorites");
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }


  Future<void> resetFavorites() async {
    state = const AsyncLoading();
    await getFavorites();
  }
}
