import 'dart:convert';

class TruckLocation {
  final String uid;
  final String name;
  final double lat;
  final double lng;
  TruckLocation({
    required this.uid,
    required this.name,
    required this.lat,
    required this.lng,
  });

  TruckLocation copyWith({
    String? uid,
    String? name,
    double? lat,
    double? lng,
  }) {
    return TruckLocation(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  factory TruckLocation.fromMap(Map<String, dynamic> map) {
    return TruckLocation(
      uid: map['uid'] as String,
      name: map['name'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory TruckLocation.fromJson(String source) =>
      TruckLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TruckLocation(uid: $uid, name: $name, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruckLocation &&
        other.uid == uid &&
        other.name == name &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
