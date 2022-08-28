import 'dart:convert';

class ComplainReq {
  final String reqId;
  final String email;
  final String detail;
  ComplainReq({
    required this.reqId,
    required this.email,
    required this.detail,
  });

  ComplainReq copyWith({
    String? reqId,
    String? email,
    String? detail,
  }) {
    return ComplainReq(
      reqId: reqId ?? this.reqId,
      email: email ?? this.email,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'req_id': reqId,
      'email': email,
      'detail': detail,
    };
  }

  factory ComplainReq.fromMap(Map<String, dynamic> map) {
    return ComplainReq(
      reqId: map['req_id'] as String,
      email: map['email'] as String,
      detail: map['detail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplainReq.fromJson(String source) =>
      ComplainReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ComplainReq(reqId: $reqId, email: $email, detail: $detail)';

  @override
  bool operator ==(covariant ComplainReq other) {
    if (identical(this, other)) return true;

    return other.reqId == reqId &&
        other.email == email &&
        other.detail == detail;
  }

  @override
  int get hashCode => reqId.hashCode ^ email.hashCode ^ detail.hashCode;
}
