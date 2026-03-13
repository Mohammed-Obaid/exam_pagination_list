import 'property_event.dart';
import 'property_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_pagination_list/features/properties/domain/usecases/get_properties.dart';


class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final GetProperties getProperties;

  PropertyBloc(this.getProperties) : super(const PropertyState()) {
    on<FetchProperties>(_onFetch);
    on<LoadMoreProperties>(_onLoadMore);
  }

  Future<void> _onFetch(
      FetchProperties event, Emitter<PropertyState> emit) async {
    // Reset to first page and clear previous errors/data when fetching.
    emit(state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      properties: [],
      hasReachedMax: false,
      page: 1,
      error: null,
    ));

    final result = await getProperties(1);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          properties: [],
          hasReachedMax: false,
          error: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          properties: data,
          isLoading: false,
           isLoadingMore: false,
          page: 1,
          hasReachedMax: data.isEmpty,
          error: null,
        ));
      },
    );
  }

  Future<void> _onLoadMore(
      LoadMoreProperties event, Emitter<PropertyState> emit) async {
    if (state.hasReachedMax || state.isLoading || state.isLoadingMore) {
      return;
    }

    final nextPage = state.page + 1;

    emit(state.copyWith(
      isLoadingMore: true,
      error: null,
    ));


    final result = await getProperties(nextPage);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingMore: false,
          error: failure.message,
        ));
      },
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            isLoadingMore: false,
            hasReachedMax: true,
          ));
        } else {
          emit(state.copyWith(
            properties: [...state.properties, ...data],
            page: nextPage,
            isLoadingMore: false,
          ));
        }
      },
    );
  }
}
