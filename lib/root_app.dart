import 'package:flutter/material.dart';
import 'package:recepten_app_flutter/features/favorites/pages/favorites_page.dart';
import 'package:recepten_app_flutter/features/recipes/pages/recipes_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int currentIndex = 0;

  final pages = [RecipesPage(), FavoritesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
          onDestinationSelected: (index){
          setState(() {
            currentIndex = index;
          });
          },
          destinations: [
        NavigationDestination(
            icon: Icon (Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Recipes"
        ),
        NavigationDestination(
            icon: Icon(Icons.favorite_border_outlined),
            selectedIcon: Icon(Icons.favorite),
            label: "Favorites",
        ),
      ]),
    );
  }
}