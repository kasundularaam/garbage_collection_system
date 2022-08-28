import 'dart:convert';

class Complain {
  final int id;
  final String reqId;
  final String email;
  final String detail;
  Complain({
    required this.id,
    required this.reqId,
    required this.email,
    required this.detail,
  });

  Complain copyWith({
    int? id,
    String? reqId,
    String? email,
    String? detail,
  }) {
    return Complain(
      id: id ?? this.id,
      reqId: reqId ?? this.reqId,
      email: email ?? this.email,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'req_id': reqId,
      'email': email,
      'detail': detail,
    };
  }

  factory Complain.fromMap(Map<String, dynamic> map) {
    return Complain(
      id: map['id'] as int,
      reqId: map['req_id'] as String,
      email: map['email'] as String,
      detail: map['detail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Complain.fromJson(String source) =>
      Complain.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Complain(id: $id, reqId: $reqId, email: $email, detail: $detail)';
  }

  @override
  bool operator ==(covariant Complain other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reqId == reqId &&
        other.email == email &&
        other.detail == detail;
  }

  @override
  int get hashCode {
    return id.hashCode ^ reqId.hashCode ^ email.hashCode ^ detail.hashCode;
  }
}
