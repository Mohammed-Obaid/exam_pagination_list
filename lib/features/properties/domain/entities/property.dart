import 'package:equatable/equatable.dart';

import 'address.dart';
import 'lat_long.dart';
import 'listing_sub_type.dart';

class Property extends Equatable {
  final String? id;
  final String price;
  final int unformattedPrice;
  final int beds;
  final int baths;
  final int area;
  final int livingArea;
  final String homeType;
  final String marketingStatus;
  final String homeStatus;
  final int rentZestimate;
  final ListingSubType listingSubType;
  final int timeOnZillow;
  final bool has3DModel;
  final Address address;
  final LatLong latLong;
  final String statusText;
  final String imgSrc;
  final String detailUrl;
  final int daysOnZillow;
  final int zestimate;

  const Property({
    this.id,
    required this.price,
    required this.unformattedPrice,
    required this.beds,
    required this.baths,
    required this.area,
    required this.livingArea,
    required this.homeType,
    required this.marketingStatus,
    required this.homeStatus,
    required this.rentZestimate,
    required this.listingSubType,
    required this.timeOnZillow,
    required this.has3DModel,
    required this.address,
    required this.latLong,
    required this.statusText,
    required this.imgSrc,
    required this.detailUrl,
    required this.daysOnZillow,
    required this.zestimate,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        unformattedPrice,
        beds,
        baths,
        area,
        livingArea,
        homeType,
        marketingStatus,
        homeStatus,
        rentZestimate,
        listingSubType,
        timeOnZillow,
        has3DModel,
        address,
        latLong,
        statusText,
        imgSrc,
        detailUrl,
        daysOnZillow,
        zestimate,
      ];
}
