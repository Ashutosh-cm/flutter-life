import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void saveNote() {

    Provider.of<NotesProvider>(context, listen: false).addNote(
      titleController.text,
      bodyController.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: bodyController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write your note...",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveNote,
              child: const Text("Save Note"),
            )
          ],
        ),
      ),
    );
  }
}