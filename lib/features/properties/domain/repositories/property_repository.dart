import 'package:dartz/dartz.dart';
import 'package:exam_pagination_list/core/error/failures.dart';
import 'package:exam_pagination_list/features/properties/domain/entities/property.dart';

abstract class PropertyRepository {
  Future<Either<Failure, List<Property>>> getProperties(int page);
}
