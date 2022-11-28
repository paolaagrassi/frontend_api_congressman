// ignore_for_file: avoid_dynamic_calls, avoid_function_literals_in_foreach_calls, unnecessary_statements, always_declare_return_types, type_annotate_public_apis
import 'dart:convert';
import 'dart:core';

import 'package:frontend_api_congressman/congressmans/core/clients/clients.dart';
import 'package:frontend_api_congressman/congressmans/core/serializers/serializers.dart';
import 'package:frontend_api_congressman/congressmans/core/wrappers/result.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';

abstract class CongressmanRepository {
  final HttpClient httpClient;
  final LocalStorageClient localStorage;

  CongressmanRepository({
    required this.httpClient,
    required this.localStorage,
  });

  Future<Result<List<CongressmanModel>>> getAllCongressmans();

  Future<Result<CongressmanMoreInfoModel>> getCongressmanMoreInfo({
    required String? id,
  });

  Future<Result<bool>> saveAllFavoritedCongressmanToLocalStorage(
    List<CongressmanModel> congressmanList,
  );

  Future<Result<List<CongressmanModel>>> getFavoritedCongressmanFromStorage();
}

class CongressmanRepositoryImpl implements CongressmanRepository {
  @override
  late HttpClient httpClient;

  @override
  late LocalStorageClient localStorage;

  CongressmanRepositoryImpl({
    required this.httpClient,
    required this.localStorage,
  });

  @override
  Future<Result<List<CongressmanModel>>> getAllCongressmans() async {
    try {
      final response = await httpClient.get(
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

  @override
  Future<Result<CongressmanMoreInfoModel>> getCongressmanMoreInfo({
    required String? id,
  }) async {
    try {
      final response = await httpClient
          .get('https://dadosabertos.camara.leg.br/api/v2/deputados/$id');

      final rawList = response['dados'] as Map<String, dynamic>;

      return ResultSuccess(
        CongressmanMoreInfoSerializer.fromMap(rawList),
      );
    } catch (e) {
      return ResultError(BaseError(message: 'Error loading congressmans list'));
    }
  }

  @override
  Future<Result<bool>> saveAllFavoritedCongressmanToLocalStorage(
    List<CongressmanModel> congressmanList,
  ) async {
    try {
      await localStorage.set(
        'favorited',
        json.encode(
          congressmanList.map((e) => CongressmanSerializer.toJson(e)).toList(),
        ),
      );

      return ResultSuccess(true);
    } catch (e) {
      return ResultError(BaseError(message: 'Error saving congressmans list'));
    }
  }

  @override
  Future<Result<List<CongressmanModel>>>
      getFavoritedCongressmanFromStorage() async {
    try {
      final response = await localStorage.get('favorited');

      if (response != null) {
        final rawList = json.decode(response as String) as List;

        return ResultSuccess(
          rawList
              .map(
                (rawCongressman) => CongressmanSerializer.fromMap(
                  json.decode(rawCongressman as String) as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
      }

      return ResultSuccess([]);
    } catch (e) {
      return ResultError(
        BaseError(message: 'Error loading congressmans favorite list'),
      );
    }
  }
}
