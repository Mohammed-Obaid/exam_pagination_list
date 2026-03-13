import 'package:exam_pagination_list/features/properties/domain/entities/property.dart';
import 'address_model.dart';
import 'lat_long_model.dart';
import 'listing_sub_type_model.dart';

class PropertyModel extends Property {
  const PropertyModel({
    String? id,
    required String price,
    required int unformattedPrice,
    required int beds,
    required int baths,
    required int area,
    required int livingArea,
    required String homeType,
    required String marketingStatus,
    required String homeStatus,
    required int rentZestimate,
    required ListingSubTypeModel listingSubType,
    required int timeOnZillow,
    required bool has3DModel,
    required AddressModel address,
    required LatLongModel latLong,
    required String statusText,
    required String imgSrc,
    required String detailUrl,
    required int daysOnZillow,
    required int zestimate,
  }) : super(
          id: id,
          price: price,
          unformattedPrice: unformattedPrice,
          beds: beds,
          baths: baths,
          area: area,
          livingArea: livingArea,
          homeType: homeType,
          marketingStatus: marketingStatus,
          homeStatus: homeStatus,
          rentZestimate: rentZestimate,
          listingSubType: listingSubType,
          timeOnZillow: timeOnZillow,
          has3DModel: has3DModel,
          address: address,
          latLong: latLong,
          statusText: statusText,
          imgSrc: imgSrc,
          detailUrl: detailUrl,
          daysOnZillow: daysOnZillow,
          zestimate: zestimate,
        );

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      price: json['price'],
      unformattedPrice: json['unformattedPrice'] ?? 0,
      beds: json['beds'] ?? 0,
      baths: json['baths'] ?? 0,
      area: json['area'] ?? 0,
      livingArea: json['livingArea'] ?? 0,
      homeType: json['homeType'],
      marketingStatus: json['marketingStatus'],
      homeStatus: json['homeStatus'],
      rentZestimate: json['rentZestimate'] ?? 0,
      listingSubType: json['listingSubType'] != null
          ? ListingSubTypeModel.fromJson(
              json['listingSubType'] as Map<String, dynamic>,
            )
          : const ListingSubTypeModel(isFSBA: false, isOpenHouse: false),
      timeOnZillow: json['timeOnZillow'] ?? 0,
      has3DModel: json['has3DModel'],
      address: AddressModel.fromJson(json['address']),
      latLong: LatLongModel.fromJson(json['latLong']),
      statusText: json['statusText'],
      imgSrc: json['imgSrc'],
      detailUrl: json['detailUrl'],
      daysOnZillow: json['daysOnZillow'] ?? 0,
      zestimate: json['zestimate'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'unformattedPrice': unformattedPrice,
      'beds': beds,
      'baths': baths,
      'area': area,
      'livingArea': livingArea,
      'homeType': homeType,
      'marketingStatus': marketingStatus,
      'homeStatus': homeStatus,
      'rentZestimate': rentZestimate,
      'listingSubType': (listingSubType as ListingSubTypeModel).toJson(),
      'timeOnZillow': timeOnZillow,
      'has3DModel': has3DModel,
      'address': (address as AddressModel).toJson(),
      'latLong': (latLong as LatLongModel).toJson(),
      'statusText': statusText,
      'imgSrc': imgSrc,
      'detailUrl': detailUrl,
      'daysOnZillow': daysOnZillow,
      'zestimate': zestimate,
    };
  }
}
