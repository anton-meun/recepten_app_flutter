import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recepten_app_flutter/entities/basic_recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../api/network.dart';

part 'recipes_by_category_serves.g.dart';

@riverpod
Future<List<BasicRecipe>> recipesByCategory(Ref ref, String category) async {
  final response = await dio.get('/filter.php?c=$category');
  if (response.statusCode != 200) {
    throw Exception(response.statusMessage);
  }

  final data = response.data['meals'];

  return List.from(data).map((recipe) => BasicRecipe.fromJson(recipe)).toList();
}
