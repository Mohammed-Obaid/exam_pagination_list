import 'package:exam_pagination_list/core/error/failures.dart';

import 'package:exam_pagination_list/features/properties/domain/entities/property.dart';
import 'package:exam_pagination_list/features/properties/domain/repositories/property_repository.dart';
import 'package:dartz/dartz.dart';

class GetProperties {
  final PropertyRepository repository;

  GetProperties(this.repository);

  Future<Either<Failure, List<Property>>> call(int page) {
    return repository.getProperties(page);
  }
}
