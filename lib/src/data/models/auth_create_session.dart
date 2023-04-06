import 'dart:convert';

class AuthCreateSession {
  final String userId;
  final String createdAt;

  AuthCreateSession({
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': userId});
    result.addAll({'created_at': createdAt});

    return result;
  }

  factory AuthCreateSession.fromMap(Map<String, dynamic> map) {
    return AuthCreateSession(
      userId: map['user_id'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthCreateSession.fromJson(String source) =>
      AuthCreateSession.fromMap(json.decode(source));
}
