import 'package:flutter/material.dart';

class RecipesSearchBar extends StatelessWidget {
  const RecipesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: "Search for recipes", // Text in bar
        barElevation: WidgetStatePropertyAll(3), // Bar shadow
        barSide: WidgetStatePropertyAll(
            BorderSide(color: Colors.orange.shade400)), // Bar color
        suggestionsBuilder: (context, controller) {
          return [];
        }
    );
  }
}
