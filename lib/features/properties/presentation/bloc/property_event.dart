import 'package:equatable/equatable.dart';

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object?> get props => [];
}

class FetchProperties extends PropertyEvent {}

class LoadMoreProperties extends PropertyEvent {}
