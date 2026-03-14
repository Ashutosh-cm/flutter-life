import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/notes_provider.dart';
import 'create_note_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<NotesProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 40, bottom: 20),
                    child: Text(
                      "What's on your mind",
                      style: GoogleFonts.jersey10(
                        fontSize: 42,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notesData.items.length,
                      itemBuilder: (ctx, i) {
                        final note = notesData.items[i];
                        // Format the date for display
                        final String timeString = note.createdAt != null
                            ? "${note.createdAt!.hour}:${note.createdAt!.minute.toString().padLeft(2, '0')}"
                            : "--:--";

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              // Open CreateNoteScreen and PASS the existing note
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateNoteScreen(existingNote: note),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            note.title,
                                            style: GoogleFonts.jersey10(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            timeString,
                                            style: const TextStyle(fontSize: 10, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        note.body,
                                        maxLines: 2, // Only show 2 lines
                                        overflow: TextOverflow.ellipsis, // Adds the "..."
                                        style: GoogleFonts.jersey10(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 40,
                left: 25,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNoteScreen())),
                  child: Container(
                    height: 70, width: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.add, color: Color(0xFF5A1A1A), size: 45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}