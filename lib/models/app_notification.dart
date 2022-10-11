class AppNotification {
  int? id;
  String title;
  String description;
  bool isRead = false;

  AppNotification(
      {this.id,
      this.isRead = false,
      required this.title,
      required this.description});

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isRead: map['is_read'],
    );
  }
}
