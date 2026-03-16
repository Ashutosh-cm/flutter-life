import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  // 1. Reference the box we opened in main.dart
  final _box = Hive.box<Note>('notesBox');

  // 2. This getter now fetches data directly from the physical storage
  List<Note> get items {
    return _box.values.toList();
  }

  // 3. Save a new note to the storage box
  void addNote(String title, String body) {
    final newNote = Note(
      id: DateTime.now().toIso8601String(),
      title: title,
      body: body,
      createdAt: DateTime.now(),
    );

    _box.add(newNote); // Hive saves this to the phone's disk
    notifyListeners(); // Updates the UI
  }

  // 4. Update an existing note in the box
  void updateNote(String id, String newTitle, String newBody) {
    // We find the index (position) of the note with the matching ID
    final index = _box.values.toList().indexWhere((note) => note.id == id);

    if (index >= 0) {
      final updatedNote = Note(
        id: id,
        title: newTitle,
        body: newBody,
        createdAt: DateTime.now(), // Update the "Saved" time
      );

      _box.putAt(index, updatedNote); // Replaces the data at that position
      notifyListeners();
    }
  }

  // 5. Delete a note from the box
  void deleteNote(String id) {
    final index = _box.values.toList().indexWhere((note) => note.id == id);
    if (index >= 0) {
      _box.deleteAt(index); // Removes the data from the phone's disk
      notifyListeners();
    }
  }
}