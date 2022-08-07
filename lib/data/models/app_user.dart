// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  final int id;
  final String username;
  final int mobile_no;
  final String email;
  final String address;
  final String password;
  final String nic;
  final String type;
  AppUser({
    required this.id,
    required this.username,
    required this.mobile_no,
    required this.email,
    required this.address,
    required this.password,
    required this.nic,
    required this.type,
  });

  AppUser copyWith({
    int? id,
    String? username,
    int? mobile_no,
    String? email,
    String? address,
    String? password,
    String? nic,
    String? type,
  }) {
    return AppUser(
      id: id ?? this.id,
      username: username ?? this.username,
      mobile_no: mobile_no ?? this.mobile_no,
      email: email ?? this.email,
      address: address ?? this.address,
      password: password ?? this.password,
      nic: nic ?? this.nic,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'mobile_no': mobile_no,
      'email': email,
      'address': address,
      'password': password,
      'nic': nic,
      'type': type,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as int,
      username: map['username'] as String,
      mobile_no: map['mobile_no'] as int,
      email: map['email'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      nic: map['nic'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(id: $id, username: $username, mobile_no: $mobile_no, email: $email, address: $address, password: $password, nic: $nic, type: $type)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.mobile_no == mobile_no &&
        other.email == email &&
        other.address == address &&
        other.password == password &&
        other.nic == nic &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        mobile_no.hashCode ^
        email.hashCode ^
        address.hashCode ^
        password.hashCode ^
        nic.hashCode ^
        type.hashCode;
  }
}
