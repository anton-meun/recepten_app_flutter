import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recepten_app_flutter/entities/recipe_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../api/network.dart';

part 'recipes_catagories_provider.g.dart';

@riverpod
Future<List<RecipeCategory>> recipeCategories(Ref ref) async {
  final response = await dio.get('/categories.php');
  if (response.statusCode != 200) {
    throw Exception(response.statusMessage);
  }
  final data = response.data['categories'];

  return List.from(data)
      .map((category) => RecipeCategory.fromJson(category))
      .toList();
}
