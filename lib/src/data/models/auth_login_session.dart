import 'dart:convert';

class AuthLoginSession {
  final String accesToken;
  final String createdAt;

  AuthLoginSession({
    required this.accesToken,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'accesToken': accesToken});
    result.addAll({'createdAt': createdAt});

    return result;
  }

  factory AuthLoginSession.fromMap(Map<String, dynamic> map) {
    return AuthLoginSession(
      accesToken: map['accesToken'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthLoginSession.fromJson(String source) =>
      AuthLoginSession.fromMap(json.decode(source));
}
