import 'package:hive/hive.dart';

// This is CRITICAL. It tells Hive where to find the generated code.
// The name must match your filename (e.g., note.dart -> note.g.dart)
part 'note.g.dart';

@HiveType(typeId: 0) // Label 0: Identifies this class to Hive
class Note extends HiveObject {

  @HiveField(0) // Each field gets a unique index number
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final DateTime? createdAt;

  Note({
    this.id,
    required this.title,
    required this.body,
    this.createdAt,
  });

  // Keep your JSON methods for the future Spring Boot backend!
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}