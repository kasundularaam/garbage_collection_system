// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRes {
  final String status;
  final int id;
  LoginRes({
    required this.status,
    required this.id,
  });

  LoginRes copyWith({
    String? status,
    int? id,
  }) {
    return LoginRes(
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'id': id,
    };
  }

  factory LoginRes.fromMap(Map<String, dynamic> map) {
    return LoginRes(
      status: map['status'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRes.fromJson(String source) =>
      LoginRes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginRes(status: $status, id: $id)';

  @override
  bool operator ==(covariant LoginRes other) {
    if (identical(this, other)) return true;

    return other.status == status && other.id == id;
  }

  @override
  int get hashCode => status.hashCode ^ id.hashCode;
}
