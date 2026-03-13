import 'package:dio/dio.dart';
import '../models/property_model.dart';
import '../../../../config/app_constants.dart';


abstract class PropertyRemoteDataSource {
  Future<List<PropertyModel>> getProperties(int page);
}

class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  final Dio dio;

  PropertyRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PropertyModel>> getProperties(int page) async {
    final response = await dio.get(
      '${AppConstants.realEstateBaseUrl}${AppConstants.realEstateSearchByUrlPath}',
      queryParameters: {
        'url': AppConstants.zillowNewYorkSearchUrl,
        'page': page,
      },
      options: Options(
        headers: {
          'x-rapidapi-key': AppConstants.realEstateApiKey,
          'x-rapidapi-host': AppConstants.realEstateApiHost,
          'Content-Type': 'application/json',
        },
      ),
    );

    final List list = response.data['results'] as List;

    return list.map((e) => PropertyModel.fromJson(e)).toList();
  }
}
