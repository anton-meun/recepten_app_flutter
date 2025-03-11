import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:recepten_app_flutter/entities/complete_recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/network.dart';

part 'random_recipe_serves.g.dart';

@Riverpod(keepAlive: true)
Future<List<CompleteRecipe>> randomRecipes(Ref ref, [int limit = 10]) async {
  const url = "https://themealdb.com/api/json/v1/1/random.php";
  final responses = await Future.wait(List.generate(limit, (index) => dio.get(url)));
  if (responses.every((response) => response.statusCode == 200)) {
    return responses.map((response) => CompleteRecipe.fromMap(response.data['meals'][0])).toList();
  }
  return [];
}