import 'package:equatable/equatable.dart';

class ListingSubType extends Equatable {
  final bool isFSBA;
  final bool isOpenHouse;

  const ListingSubType({
    required this.isFSBA,
    required this.isOpenHouse,
  });

  @override
  List<Object?> get props => [isFSBA, isOpenHouse];
}
