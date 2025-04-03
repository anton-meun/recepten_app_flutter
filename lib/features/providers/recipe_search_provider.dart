import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:recepten_app_flutter/entities/complete_recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/network.dart';

part 'recipe_search_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<CompleteRecipe>> searchRecipesByName(Ref ref, String query) async {
  if (query.isEmpty) {
    return [];
  }

  final url = "https://www.themealdb.com/api/json/v1/1/search.php?s=$query";
  final response = await dio.get(url);

  if (response.statusCode == 200 && response.data['meals'] != null) {
    return (response.data['meals'] as List)
        .map((meal) => CompleteRecipe.fromMap(meal))
        .toList();
  }
  return [];
}
