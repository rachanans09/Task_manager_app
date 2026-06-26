class Task {
  final String id;
  final String title;
  bool isCompleted;
  final DateTime createdAt; // Stores the exact date and time

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  // Convert Task to JSON string to save to storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(), // Saves time as text
      };

  // Convert JSON string back to a Task object
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        isCompleted: json['isCompleted'] ?? false,
        createdAt: DateTime.parse(json['createdAt']), // Restores time text back to date
      );
}
