// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final bool isDriver;
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.isDriver,
  });

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    bool? isDriver,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      isDriver: isDriver ?? this.isDriver,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'isDriver': isDriver,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isDriver: map['isDriver'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(uid: $uid, name: $name, email: $email, isDriver: $isDriver)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.isDriver == isDriver;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ isDriver.hashCode;
  }
}
