// ignore_for_file: avoid_dynamic_calls, avoid_function_literals_in_foreach_calls
import 'package:frontend_api_congressman/search/core/serializers/serializers.dart';
import 'package:frontend_api_congressman/search/core/services/services.dart';
import 'package:frontend_api_congressman/search/core/wrappers/result.dart';
import 'package:frontend_api_congressman/search/models/models.dart';

abstract class CongressmanRepository {
  final HttpService httpService;

  CongressmanRepository({
    required this.httpService,
  });

  Future<Result<List<CongressmanModel>>> getAllCongressmans();
}

class CongressmanRepositoryImpl implements CongressmanRepository {
  @override
  late HttpService httpService;

  CongressmanRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<Result<List<CongressmanModel>>> getAllCongressmans() async {
    try {
      final response = await httpService.get(
        'https://dadosabertos.camara.leg.br/api/v2/deputados?',
      );

      final rawList = response['dados'] as List;

      final congressmansList = <CongressmanModel>[];

      rawList.forEach((element) {
        congressmansList.add(
          CongressmanSerializer.fromMap(element as Map<String, dynamic>),
        );
      });

      return ResultSuccess(
        congressmansList,
      );
    } catch (e) {
      return ResultError(BaseError(message: 'Error loading congressmans list'));
    }
  }
}
