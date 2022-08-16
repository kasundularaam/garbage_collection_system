import 'dart:convert';

class TruckLocation {
  final int id;
  final String name;
  final double lat;
  final double lng;
  final int mobileNum;
  TruckLocation({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.mobileNum,
  });

  TruckLocation copyWith({
    int? id,
    String? name,
    double? lat,
    double? lng,
    int? mobileNum,
  }) {
    return TruckLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      mobileNum: mobileNum ?? this.mobileNum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'mobileNum': mobileNum,
    };
  }

  factory TruckLocation.fromMap(Map<String, dynamic> map) {
    return TruckLocation(
      id: map['id'] as int,
      name: map['name'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      mobileNum: map['mobileNum'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TruckLocation.fromJson(String source) =>
      TruckLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TruckLocation(id: $id, name: $name, lat: $lat, lng: $lng, mobileNum: $mobileNum)';
  }

  @override
  bool operator ==(covariant TruckLocation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.lng == lng &&
        other.mobileNum == mobileNum;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        mobileNum.hashCode;
  }
}
