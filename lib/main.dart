import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recepten_app_flutter/root_app.dart';
import 'package:recepten_app_flutter/features/recipes/pages/recipes_page.dart';
import 'package:recepten_app_flutter/features/authenticate/pages/register_page.dart';
import 'package:recepten_app_flutter/features/authenticate/pages/login_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade800),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme().copyWith(
          titleLarge: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
        chipTheme: ChipThemeData(
          shape: ContinuousRectangleBorder( borderRadius: BorderRadius.circular(25))
        ),
      ),
      initialRoute: '/login',  // Start page
      routes: {
        '/recipes': (context) => RecipesPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => RootApp(),
      },
    );
  }
}
