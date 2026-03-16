import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart'; // 1. Added Hive import
import './models/note.dart'; // 2. Added Note model import
import './providers/notes_provider.dart';
import './screens/home_screen.dart';

void main() async {
  // 3. This is required when using 'async' in the main function
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Initialize Hive for Flutter
  await Hive.initFlutter();

  // 5. Register the Adapter so Hive knows how to read your Note class
  Hive.registerAdapter(NoteAdapter());

  // 6. Open the 'box' where notes will be stored physically
  await Hive.openBox<Note>('notesBox');

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
        textTheme: GoogleFonts.jersey10TextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}