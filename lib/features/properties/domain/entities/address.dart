import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String street;
  final String city;
  final String state;
  final String zipcode;

  const Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipcode,
  });

  @override
  List<Object?> get props => [street, city, state, zipcode];
}
