import 'package:exam_pagination_list/features/properties/domain/entities/lat_long.dart';

class LatLongModel extends LatLong {
  const LatLongModel({
    required double latitude,
    required double longitude,
  }) : super(latitude: latitude, longitude: longitude);

  factory LatLongModel.fromJson(Map<String, dynamic> json) {
    return LatLongModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
