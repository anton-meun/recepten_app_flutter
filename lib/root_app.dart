import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recepten_app_flutter/features/favorites/pages/favorites_page.dart';
import 'package:recepten_app_flutter/features/recipes/pages/recipes_page.dart';
import 'package:recepten_app_flutter/features/authenticate/pages/login_page.dart';
import 'package:recepten_app_flutter/features/serves/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'features/serves/get_favorites_serves.dart';

class RootApp extends ConsumerStatefulWidget {
  const RootApp({super.key});

  @override
  ConsumerState<RootApp> createState() => _RootAppState();
}

class _RootAppState extends ConsumerState<RootApp> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _storage.read(key: "auth_token");
    ref.read(authProvider.notifier).state = token; // set token
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.watch(authProvider); // Check if token is present

    if (token == null) {
      return const LoginPage(); // Redirect to login if no token is present
    }

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [RecipesPage(), FavoritesPage()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });

          // get favorites if favorites is selected
          if (index == 1) {
            ref.read(favoritesFetcherProvider.notifier).getFavorites();
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Recipes"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),
    );
  }
}

