class Note {
  final String? id;
  final String title;
  final String body;
  final DateTime? createdAt;

  Note({
    this.id,
    required this.title,
    required this.body,
    this.createdAt,
  });

  // This is used when sending data TO your Spring Boot API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      // If createdAt is null, we send the current time
      'createdAt': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  // This is used when receiving data FROM your Spring Boot MongoDB
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