import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recepten_app_flutter/features/recipes/pages/recipe_details_page.dart';
import '../../../widgets/recipe_card.dart';
import '../../../widgets/spinner.dart';
import '../../providers/random_recipe_provider.dart';

class Rendomrecipes extends ConsumerWidget {
  const Rendomrecipes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(randomRecipesProvider(16));
    return recipes.when(
      data: (data) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecipeDetailsPage(recipe: recipe),
                ));
              },
            );
          },
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: Spinner()),
    );
  }
}
