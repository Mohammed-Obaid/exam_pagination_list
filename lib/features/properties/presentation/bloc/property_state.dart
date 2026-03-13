import 'package:equatable/equatable.dart';
import 'package:exam_pagination_list/features/properties/domain/entities/property.dart';



class PropertyState extends Equatable {
  final List<Property> properties;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final int page;
  final String? error;

  const PropertyState({
    this.properties = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.page = 1,
    this.error,
  });

  PropertyState copyWith({
    List<Property>? properties,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedMax,
    int? page,
    String? error,
  }) {
    return PropertyState(
      properties: properties ?? this.properties,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [properties, isLoading, isLoadingMore, hasReachedMax, page, error];
}
