class DeadlineItem {
  const DeadlineItem({
    required this.id,
    required this.title,
    required this.course,
    required this.platform,
    required this.status,
    required this.dueAt,
  });

  final String id;
  final String title;
  final String? course;
  final String platform;
  final String status;
  final DateTime? dueAt;

  factory DeadlineItem.fromJson(Map<String, dynamic> json) => DeadlineItem(
        id: json["id"] as String? ?? "",
        title: json["title"] as String? ?? "Untitled",
        course: json["course"] as String?,
        platform: json["platform"] as String? ?? "unknown",
        status: json["status"] as String? ?? "pending",
        dueAt: json["due_at"] is String
            ? DateTime.tryParse(json["due_at"] as String)
            : ((json["due"] as num?) != null
                ? DateTime.fromMillisecondsSinceEpoch(
                    ((json["due"] as num).toInt()) * 1000)
                : null),
      );
}
