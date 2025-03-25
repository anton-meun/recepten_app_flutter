import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/logout.dart';
import '../../recipes/pages/recipe_details_page.dart';
import '../../providers/get_favorites_provider.dart';
import '../../providers/favorites_provider.dart';
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
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 5,
              crossAxisSpacing: 1,
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
                actions: IconButton(
                  icon: Icon(
                      Icons.edit, color: Colors.deepOrange[100], size: 18),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () => _showEditDialog(context, favoriteRecipe),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: Spinner()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showEditDialog(BuildContext context, favoriteRecipe) {
    final TextEditingController _commentController =
    TextEditingController(text: favoriteRecipe.comment);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Note"),
          content: TextField(
            controller: _commentController,
            decoration: const InputDecoration(labelText: "Enter new note"),
            maxLines: 3,
            maxLength: 100,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final newComment = _commentController.text.trim();
                if (newComment.isNotEmpty) {

                  final recipeId = int.tryParse(
                      favoriteRecipe.recipe.id.toString()) ?? 0;

                  await ref.read(favoritesNotifierProvider.notifier)
                      .updateFavoriteComment(recipeId, newComment);

                  // Update the favorites list after updating the comment
                  await ref.read(favoritesFetcherProvider.notifier)
                      .getFavorites();

                }
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

