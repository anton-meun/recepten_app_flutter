import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../serves/recipe_search_serves.dart';
import '../pages/recipe_details_page.dart';

class RecipesSearchBar extends ConsumerStatefulWidget {
  const RecipesSearchBar({super.key});

  @override
  ConsumerState<RecipesSearchBar> createState() => _RecipesSearchBarState();
}

class _RecipesSearchBarState extends ConsumerState<RecipesSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      ref.invalidate(searchRecipesByNameProvider);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text;
    final searchResults = ref.watch(searchRecipesByNameProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search for recipes',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade500),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 10),
        if (query.isNotEmpty)
          searchResults.when(
            data: (recipes) {
              if (recipes.isEmpty) {
                return Center(child: Text("No recipes found"));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: recipes.take(3).length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return ListTile(
                    title: Text(recipe.name),
                    subtitle: Text(recipe.category),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        recipe.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailsPage(recipe: recipe),
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
      ],
    );
  }
}
