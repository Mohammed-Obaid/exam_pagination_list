import 'package:exam_pagination_list/features/properties/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required String street,
    required String city,
    required String state,
    required String zipcode,
  }) : super(
          street: street,
          city: city,
          state: state,
          zipcode: zipcode,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };
  }
}
