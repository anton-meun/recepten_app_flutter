import 'package:flutter/material.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Recipes",
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}
