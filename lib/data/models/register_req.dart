import 'dart:convert';

class RegisterReq {
  final String username;
  final int mobileNo;
  final String email;
  final String address;
  final String password;
  final String nic;
  final String type;
  RegisterReq({
    required this.username,
    required this.mobileNo,
    required this.email,
    required this.address,
    required this.password,
    required this.nic,
    required this.type,
  });

  RegisterReq copyWith({
    String? username,
    int? mobileNo,
    String? email,
    String? address,
    String? password,
    String? nic,
    String? type,
  }) {
    return RegisterReq(
      username: username ?? this.username,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      address: address ?? this.address,
      password: password ?? this.password,
      nic: nic ?? this.nic,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'mobile_no': mobileNo,
      'email': email,
      'address': address,
      'password': password,
      'nic': nic,
      'type': type,
    };
  }

  factory RegisterReq.fromMap(Map<String, dynamic> map) {
    return RegisterReq(
      username: map['username'] as String,
      mobileNo: map['mobile_no'] as int,
      email: map['email'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      nic: map['nic'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterReq.fromJson(String source) =>
      RegisterReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterReq(username: $username, mobileNo: $mobileNo, email: $email, address: $address, password: $password, nic: $nic, type: $type)';
  }

  @override
  bool operator ==(covariant RegisterReq other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.mobileNo == mobileNo &&
        other.email == email &&
        other.address == address &&
        other.password == password &&
        other.nic == nic &&
        other.type == type;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        mobileNo.hashCode ^
        email.hashCode ^
        address.hashCode ^
        password.hashCode ^
        nic.hashCode ^
        type.hashCode;
  }
}
