// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GarbageRequest {
  final int id;
  final String user;
  final int mobileNo;
  final String garbageType;
  final String location;
  final double longitude;
  final double latitude;
  final String status;
  GarbageRequest({
    required this.id,
    required this.user,
    required this.mobileNo,
    required this.garbageType,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.status,
  });

  GarbageRequest copyWith({
    int? id,
    String? user,
    int? mobileNo,
    String? garbageType,
    String? location,
    double? longitude,
    double? latitude,
    String? status,
  }) {
    return GarbageRequest(
      id: id ?? this.id,
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
      'id': id,
      'user': user,
      'mobile_no': mobileNo,
      'garbage_type': garbageType,
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'status': status,
    };
  }

  factory GarbageRequest.fromMap(Map<String, dynamic> map) {
    return GarbageRequest(
      id: map['id'] as int,
      user: map['user'] as String,
      mobileNo: map['mobile_no'] as int,
      garbageType: map['garbage_type'] as String,
      location: map['location'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GarbageRequest.fromJson(String source) =>
      GarbageRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GarbageRequest(id: $id, user: $user, mobileNo: $mobileNo, garbageType: $garbageType, location: $location, longitude: $longitude, latitude: $latitude, status: $status)';
  }

  @override
  bool operator ==(covariant GarbageRequest other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.mobileNo == mobileNo &&
        other.garbageType == garbageType &&
        other.location == location &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        mobileNo.hashCode ^
        garbageType.hashCode ^
        location.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        status.hashCode;
  }
}
