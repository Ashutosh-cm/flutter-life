import 'package:flutter/material.dart';
import '../models/note.dart';

class NotesProvider extends ChangeNotifier {

  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(String title, String body) {

    final note = Note(
      title: title,
      body: body,
      date: DateTime.now(),
    );

    _notes.add(note);

    notifyListeners();
  }
}