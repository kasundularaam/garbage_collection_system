import 'dart:convert';

class ImageRes {
  final String status;
  final String result;
  ImageRes({
    required this.status,
    required this.result,
  });

  ImageRes copyWith({
    String? status,
    String? result,
  }) {
    return ImageRes(
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'result': result,
    };
  }

  factory ImageRes.fromMap(Map<String, dynamic> map) {
    return ImageRes(
      status: map['status'] as String,
      result: map['result'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageRes.fromJson(String source) =>
      ImageRes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageRes(status: $status, result: $result)';

  @override
  bool operator ==(covariant ImageRes other) {
    if (identical(this, other)) return true;

    return other.status == status && other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ result.hashCode;
}
