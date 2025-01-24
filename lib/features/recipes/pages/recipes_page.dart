import 'package:flutter/material.dart';
import 'package:recepten_app_flutter/features/recipes/wigets/recipes_catagories.dart';
import 'package:recepten_app_flutter/features/recipes/wigets/recipes_search_bar.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Recipes",
          style: theme.textTheme.titleLarge,
        ),
      ),

      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          // Search bar
          RecipesSearchBar(),
          SizedBox(height: 20),

          // Catagories
          Text("Catagories",
          style: theme.textTheme.titleMedium),
          SizedBox(height: 5),
          RecipesCatagories()


        ],
      ),
    );
  }
}
