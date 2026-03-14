import 'package:flutter/material.dart';
import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  final List<Note> _items = [];

  List<Note> get items => [..._items];

  // 1. Modified Add Note: Now includes the current timestamp
  void addNote(String title, String body) {
    final newNote = Note(
      // We use a String timestamp as a temporary ID until MongoDB generates one
      id: DateTime.now().toIso8601String(),
      title: title,
      body: body,
      createdAt: DateTime.now(),
    );

    _items.add(newNote);
    notifyListeners();
  }

  // 2. New Update Note: Finds the note by ID and replaces it
  void updateNote(String id, String newTitle, String newBody) {
    final index = _items.indexWhere((note) => note.id == id);

    if (index >= 0) {
      _items[index] = Note(
        id: id, // Keep the same ID
        title: newTitle,
        body: newBody,
        createdAt: DateTime.now(), // Update time to show last modified
      );
      notifyListeners();
    }
  }
}