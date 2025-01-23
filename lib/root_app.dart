import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(
            icon: Icon (Icons.home),
            label: "Recipes"
        ),
        NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favorites",
        ),
      ]),
    );
  }
}