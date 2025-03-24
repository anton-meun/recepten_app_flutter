import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/logout.dart';
import '../../recipes/pages/recipe_details_page.dart';
import '../../serves/get_favorites_serves.dart';
import '../../../widgets/recipe_card.dart';
import '../../../widgets/spinner.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoritesFetcherProvider.notifier).getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesFetcherProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context, ref),
          ),
        ],
      ),
      body: favoritesState.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favoriteRecipe = favorites[index];
              final recipe = favoriteRecipe.recipe;
              final comment = favoriteRecipe.comment;

              return RecipeCard(
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipeDetailsPage(recipe: recipe),
                  ));
                },
                comment: comment.isEmpty ? "No note" : comment,
              );
            },
          );
        },
        loading: () => const Center(child: Spinner()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
