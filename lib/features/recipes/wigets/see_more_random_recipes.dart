import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/logout.dart';
import '../../../widgets/recipe_card.dart';
import '../../../widgets/spinner.dart';
import '../../serves/random_recipe_serves.dart';
import '../pages/recipe_details_page.dart';

class SeeMoreRecipesPage extends ConsumerWidget {
  const SeeMoreRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(randomRecipesProvider(30));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Random recipes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context, ref),
          ),
        ],
      ),
      body: recipes.when(
        data: (data) {
          return RefreshIndicator.adaptive(
            onRefresh: () async => ref.invalidate(randomRecipesProvider(32)),
            child: GridView.builder(
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailsPage(recipe: recipe),
                    ));
                  },
                );
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const Center(child: Spinner());
        },
      ),
    );
  }
}
