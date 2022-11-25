// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls, avoid_dynamic_calls
import 'package:frontend_api_congressman/search/core/serializers/congressman_more_info_serializer.dart';
import 'package:frontend_api_congressman/search/core/services/services.dart';
import 'package:frontend_api_congressman/search/core/wrappers/result.dart';
import 'package:frontend_api_congressman/search/models/models.dart';

abstract class CongressmanMoreInfoRepository {
  final HttpService httpService;

  CongressmanMoreInfoRepository({
    required this.httpService,
  });

  Future<Result<CongressmanMoreInfoModel>> getCongressmanInfo({
    required String? id,
  });
}

class CongressmanMoreInfoRepositoryImpl
    implements CongressmanMoreInfoRepository {
  @override
  late HttpService httpService;

  CongressmanMoreInfoRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<Result<CongressmanMoreInfoModel>> getCongressmanInfo({
    required String? id,
  }) async {
    try {
      final response = await httpService
          .get('https://dadosabertos.camara.leg.br/api/v2/deputados/$id');

      final rawList = response['dados'] as Map<String, dynamic>;

      return ResultSuccess(
        CongressmanMoreInfoSerializer.fromMap(rawList),
      );
    } catch (e) {
      return ResultError(BaseError(message: 'Error loading congressmans list'));
    }
  }
}
