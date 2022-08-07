import 'dart:convert';

import 'package:flutter/foundation.dart';

class GarbageRequest {
  final String id;
  final bool isHome;
  final double lat;
  final double lng;
  final int timestamp;
  final List<String> contains;
  final int weight;
  final int collectedTime;
  GarbageRequest({
    required this.id,
    required this.isHome,
    required this.lat,
    required this.lng,
    required this.timestamp,
    required this.contains,
    required this.weight,
    required this.collectedTime,
  });

  GarbageRequest copyWith({
    String? id,
    bool? isHome,
    double? lat,
    double? lng,
    int? timestamp,
    List<String>? contains,
    int? weight,
    int? collectedTime,
  }) {
    return GarbageRequest(
      id: id ?? this.id,
      isHome: isHome ?? this.isHome,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      timestamp: timestamp ?? this.timestamp,
      contains: contains ?? this.contains,
      weight: weight ?? this.weight,
      collectedTime: collectedTime ?? this.collectedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isHome': isHome,
      'lat': lat,
      'lng': lng,
      'timestamp': timestamp,
      'contains': contains,
      'weight': weight,
      'collectedTime': collectedTime,
    };
  }

  factory GarbageRequest.fromMap(Map<String, dynamic> map) {
    return GarbageRequest(
      id: map['id'] as String,
      isHome: map['isHome'] as bool,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      timestamp: map['timestamp'] as int,
      contains: List<String>.from((map['contains'] as List<String>)),
      weight: map['weight'] as int,
      collectedTime: map['collectedTime'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GarbageRequest.fromJson(String source) =>
      GarbageRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GarbageRequest(id: $id, isHome: $isHome, lat: $lat, lng: $lng, timestamp: $timestamp, contains: $contains, weight: $weight, collectedTime: $collectedTime)';
  }

  @override
  bool operator ==(covariant GarbageRequest other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isHome == isHome &&
        other.lat == lat &&
        other.lng == lng &&
        other.timestamp == timestamp &&
        listEquals(other.contains, contains) &&
        other.weight == weight &&
        other.collectedTime == collectedTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isHome.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        timestamp.hashCode ^
        contains.hashCode ^
        weight.hashCode ^
        collectedTime.hashCode;
  }
}
