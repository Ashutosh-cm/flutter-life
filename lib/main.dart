import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import here
import './providers/notes_provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        brightness: Brightness.dark,
        // This makes Jersey 10 the default font for the entire app!
        textTheme: GoogleFonts.jersey10TextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}