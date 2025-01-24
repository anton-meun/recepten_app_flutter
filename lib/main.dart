import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recepten_app_flutter/root_app.dart';

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipe App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade800),
            scaffoldBackgroundColor: Colors.white60,
            useMaterial3: true,
            textTheme: GoogleFonts.openSansTextTheme().copyWith(
                titleLarge: GoogleFonts.openSans(
                    fontSize: 30, fontWeight: FontWeight.bold),
                titleMedium:
                    GoogleFonts.openSans(fontWeight: FontWeight.bold))),
        home: RootApp());
  }
}
