import 'dart:convert';

class AuthLoginSession {
  final String accessToken;
  final String createdAt;

  AuthLoginSession({
    required this.accessToken,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'access_token': accessToken});
    result.addAll({'created_at': createdAt});

    return result;
  }

  factory AuthLoginSession.fromMap(Map<String, dynamic> map) {
    return AuthLoginSession(
      accessToken: map['access_token'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthLoginSession.fromJson(String source) =>
      AuthLoginSession.fromMap(json.decode(source));
}
