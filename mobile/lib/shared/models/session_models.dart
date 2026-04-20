String? _nonBlankString(dynamic value) {
  if (value is! String) return null;
  final text = value.trim();
  return text.isEmpty ? null : text;
}

class SessionUserSummary {
  const SessionUserSummary({
    required this.id,
    required this.username,
    required this.role,
    required this.subscription,
    required this.displayName,
    required this.email,
    required this.emailVerified,
  });

  final String id;
  final String username;
  final String role;
  final String subscription;
  final String displayName;
  final String? email;
  final bool emailVerified;

  factory SessionUserSummary.fromJson(Map<String, dynamic> json) =>
      SessionUserSummary(
        id: json["id"] as String? ?? "",
        username: json["username"] as String? ?? "",
        role: json["role"] as String? ?? "guest",
        subscription: json["subscription"] as String? ?? "trial",
        displayName: _nonBlankString(json["display_name"]) ??
            _nonBlankString(json["username"]) ??
            "Guest",
        email: _nonBlankString(json["email"]),
        emailVerified: json["email_verified"] as bool? ?? false,
      );
}

class CampusBindingSummary {
  const CampusBindingSummary({
    required this.bound,
    required this.provider,
    required this.status,
    required this.studentName,
    required this.studentId,
    required this.department,
  });

  final bool bound;
  final String provider;
  final String status;
  final String? studentName;
  final String? studentId;
  final String? department;

  factory CampusBindingSummary.fromJson(Map<String, dynamic> json) {
    final studentInfo = json["student_info"] as Map<String, dynamic>?;
    final status = json["status"] as String? ?? "unbound";
    return CampusBindingSummary(
      bound: (json["bound"] as bool?) ?? status != "unbound",
      provider: json["provider"] as String? ?? "",
      status: status,
      studentName: _nonBlankString(studentInfo?["student_name"]),
      studentId: _nonBlankString(studentInfo?["student_id"]),
      department: _nonBlankString(studentInfo?["college"]) ??
          _nonBlankString(studentInfo?["major"]),
    );
  }
}

class SessionSnapshot {
  const SessionSnapshot({
    required this.authenticated,
    required this.user,
    required this.campusBinding,
  });

  final bool authenticated;
  final SessionUserSummary? user;
  final CampusBindingSummary? campusBinding;

  factory SessionSnapshot.fromJson(Map<String, dynamic> json) {
    final bindings = ((json["campus_bindings"] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(CampusBindingSummary.fromJson)
        .toList();
    final legacyBinding = json["campus_binding"] is Map<String, dynamic>
        ? CampusBindingSummary.fromJson(
            json["campus_binding"] as Map<String, dynamic>)
        : null;
    return SessionSnapshot(
      authenticated: json["authenticated"] as bool? ?? false,
      user: json["user"] is Map<String, dynamic>
          ? SessionUserSummary.fromJson(json["user"] as Map<String, dynamic>)
          : null,
      campusBinding: bindings.isNotEmpty ? bindings.first : legacyBinding,
    );
  }
}
