import 'package:flutter/material.dart';
import 'package:recepten_app_flutter/features/recipes/wigets/recipes_catagories.dart';
import 'package:recepten_app_flutter/features/recipes/wigets/recipes_search_bar.dart';
import 'package:recepten_app_flutter/features/recipes/wigets/rendom_recipes.dart';
import 'package:recepten_app_flutter/features/recipes/wigets/see_more_random_recipes.dart';

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
          RecipesCatagories(),

          // Random Meals
          Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Random meals",style: theme.textTheme.titleMedium),
              TextButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => SeeMoreRecipesPage(),
                  ),
                );
              },
                  child: Text("See more")),

            ],
          ),
          ),
          Rendomrecipes()
        ],
      ),
    );
  }
}
