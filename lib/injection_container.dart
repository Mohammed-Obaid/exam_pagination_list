import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/properties/data/datasources/property_remote_datasource.dart';
import '../../features/properties/data/repositories/property_repository_impl.dart';
import '../../features/properties/domain/repositories/property_repository.dart';
import '../../features/properties/domain/usecases/get_properties.dart';
import '../../features/properties/presentation/bloc/property_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => PropertyBloc(sl()),
  );

  sl.registerLazySingleton(
    () => GetProperties(sl()),
  );

  sl.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<PropertyRemoteDataSource>(
    () => PropertyRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton(() => Dio());
}
