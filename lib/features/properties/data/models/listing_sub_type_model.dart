import 'package:exam_pagination_list/features/properties/domain/entities/listing_sub_type.dart';

class ListingSubTypeModel extends ListingSubType {
  const ListingSubTypeModel({
    required bool isFSBA,
    required bool isOpenHouse,
  }) : super(isFSBA: isFSBA, isOpenHouse: isOpenHouse);

  factory ListingSubTypeModel.fromJson(Map<String, dynamic> json) {
    return ListingSubTypeModel(
      isFSBA: (json['is_FSBA'] as bool?) ?? false,
      isOpenHouse: (json['is_openHouse'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_FSBA': isFSBA,
      'is_openHouse': isOpenHouse,
    };
  }
}
