import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/notes_provider.dart';
import '../models/note.dart';

class CreateNoteScreen extends StatefulWidget {
  final Note? existingNote;
  CreateNoteScreen({this.existingNote});

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingNote?.title ?? "");
    _bodyController = TextEditingController(text: widget.existingNote?.body ?? "");
  }

  void _saveNote() {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) return;
    final provider = Provider.of<NotesProvider>(context, listen: false);

    if (widget.existingNote == null) {
      provider.addNote(_titleController.text, _bodyController.text);
    } else {
      provider.updateNote(widget.existingNote!.id!, _titleController.text, _bodyController.text);
    }
    Navigator.of(context).pop();
  }

  void _deleteNote() {
    if (widget.existingNote != null) {
      Provider.of<NotesProvider>(context, listen: false).deleteNote(widget.existingNote!.id!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/create_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Status bar box
            Container(height: topPadding, width: double.infinity, color: Colors.black.withOpacity(0.4)),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        widget.existingNote == null ? "Create notes" : "Edit note",
                        style: GoogleFonts.jersey10(color: Colors.white, fontSize: 38),
                      ),
                      const SizedBox(height: 30),
                      _buildGlassBox("Title", _titleController, 1, 65),
                      const SizedBox(height: 25),
                      _buildGlassBox("Body", _bodyController, 15, 300),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _saveNote,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                "Save",
                                style: GoogleFonts.jersey10(color: Colors.black, fontSize: 24),
                              ),
                            ),
                          ),
                          if (widget.existingNote != null) ...[
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: _deleteNote,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB71C1C),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  "Delete",
                                  style: GoogleFonts.jersey10(color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBox(String hint, TextEditingController controller, int lines, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: height, width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: controller,
            maxLines: lines,
            style: GoogleFonts.jersey10(color: Colors.black, fontSize: 20),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.jersey10(color: Colors.black.withOpacity(0.5)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}