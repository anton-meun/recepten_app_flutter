import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recepten_app_flutter/entities/recipe_category.dart';
import 'package:recepten_app_flutter/features/providers/recipes_by_category_provider.dart';
import 'package:recepten_app_flutter/widgets/recipe_card.dart';
import 'package:recepten_app_flutter/widgets/spinner.dart';
import '../../../api/network.dart';
import '../../../entities/complete_recipe.dart';
import '../../../widgets/logout.dart';
import 'recipe_details_page.dart';

class RecipeCategoryPage extends ConsumerWidget {
  const RecipeCategoryPage({super.key, required this.recipeCategory});

  final RecipeCategory recipeCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipesByCategoryProvider(recipeCategory.name));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(recipeCategory.name),
        actions: [
          IconButton(
            onPressed: () => logout(context, ref),
            icon: const Icon(Icons.logout),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Hero(
              tag: recipeCategory.id,
              child: CircleAvatar(
                foregroundImage:
                    CachedNetworkImageProvider(recipeCategory.imageUrl),
              ),
            ),
          ),
        ],
      ),
      body: recipes.when(
          data: (data) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final recipe = data[index];
                return RecipeCard(
                  name: recipe.name,
                  imageUrl: recipe.imageUrl,
                  onTap: () async {
                    final response = await dio.get(
                        "https://themealdb.com/api/json/v1/1/lookup.php?i=${recipe.id}");
                    if (response.statusCode == 200) {
                      final completeRecipe =
                          CompleteRecipe.fromMap(response.data['meals'][0]);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailsPage(recipe: completeRecipe),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(child: Spinner())),
    );
  }
}
