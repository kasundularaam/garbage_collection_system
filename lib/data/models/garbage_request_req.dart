import 'dart:convert';

class GarbageRequestReq {
  final String user;
  final int mobileNo;
  final String garbageType;
  final String location;
  final double longitude;
  final double latitude;
  final String status;
  GarbageRequestReq({
    required this.user,
    required this.mobileNo,
    required this.garbageType,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.status,
  });

  GarbageRequestReq copyWith({
    String? user,
    int? mobileNo,
    String? garbageType,
    String? location,
    double? longitude,
    double? latitude,
    String? status,
  }) {
    return GarbageRequestReq(
      user: user ?? this.user,
      mobileNo: mobileNo ?? this.mobileNo,
      garbageType: garbageType ?? this.garbageType,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'mobileNo': mobileNo,
      'garbageType': garbageType,
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'status': status,
    };
  }

  factory GarbageRequestReq.fromMap(Map<String, dynamic> map) {
    return GarbageRequestReq(
      user: map['user'] as String,
      mobileNo: map['mobileNo'] as int,
      garbageType: map['garbageType'] as String,
      location: map['location'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GarbageRequestReq.fromJson(String source) =>
      GarbageRequestReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GarbageRequestReq(user: $user, mobileNo: $mobileNo, garbageType: $garbageType, location: $location, longitude: $longitude, latitude: $latitude, status: $status)';
  }

  @override
  bool operator ==(covariant GarbageRequestReq other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.mobileNo == mobileNo &&
        other.garbageType == garbageType &&
        other.location == location &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.status == status;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        mobileNo.hashCode ^
        garbageType.hashCode ^
        location.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        status.hashCode;
  }
}
