import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../serves/get_favorites_serves.dart';

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
      ),
      body: favoritesState.when(
        data: (favorites) {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favoriteRecipe = favorites[index];
              final recipe = favoriteRecipe.recipe;
              final comment = favoriteRecipe.comment;

              return ListTile(
                title: Text(recipe.name),
                subtitle: Text(comment.isEmpty ? "No comment" : comment),
                leading: Image.network(recipe.imageUrl),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
