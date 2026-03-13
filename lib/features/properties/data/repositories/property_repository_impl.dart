import 'package:dartz/dartz.dart';
import '../datasources/property_remote_datasource.dart';
import 'package:exam_pagination_list/core/error/error_mapper.dart';
import 'package:exam_pagination_list/core/error/failures.dart';
import 'package:exam_pagination_list/features/properties/domain/entities/property.dart';
import 'package:exam_pagination_list/features/properties/domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;

  PropertyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Property>>> getProperties(int page) async {
    try {
      final result = await remoteDataSource.getProperties(page);

      return Right(result);
    } catch (error, stackTrace) {
      print('ErrorInGetProperties: $error');
      print('Stacktrace: $stackTrace');

      final failure = mapErrorToFailure(error);
      return Left(failure);
    }
  }
}
