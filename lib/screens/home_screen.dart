import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'create_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),

      body: ListView.builder(
        itemCount: notesProvider.notes.length,
        itemBuilder: (context, index) {

          final note = notesProvider.notes[index];

          return Card(
            child: ListTile(
              title: Text(note.title),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(note.body),

                  const SizedBox(height: 5),

                  Text(
                    "${note.date.day}/${note.date.month}/${note.date.year}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNoteScreen(),
            ),
          );
        },
      ),
    );
  }
}