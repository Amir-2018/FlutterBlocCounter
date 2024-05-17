import 'package:latlong2/latlong.dart';

class PointLocation {
  final double lat;
  final double lng;

  const PointLocation({
    required this.lat,
    required this.lng,
  });

  factory PointLocation.fromJson(Map<String, dynamic> json) {
    return PointLocation(
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }

  factory PointLocation.fromMap(Map<String, dynamic> map) {
    return PointLocation(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory PointLocation.fromLatLng(LatLng latLng) {
    return PointLocation(
      lat: latLng.latitude,
      lng: latLng.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }



}