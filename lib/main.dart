import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_api_congressman/app.dart';
import 'package:frontend_api_congressman/search/controllers/controllers.dart';
import 'package:frontend_api_congressman/search/core/repositories/repositories.dart';
import 'package:frontend_api_congressman/search/core/services/services.dart';
import 'package:kiwi/kiwi.dart';

void main() {
  final KiwiContainer container = KiwiContainer();

  final Dio dio = Dio();

  //clients
  container.registerSingleton<HttpService>(
    (container) => DioService(dio),
  );

  //repositories
  container.registerSingleton<CongressmanRepository>(
    (container) => CongressmanRepositoryImpl(
      httpService: container.resolve<HttpService>(),
    ),
  );

  container.registerSingleton<CongressmanMoreInfoRepository>(
    (container) => CongressmanMoreInfoRepositoryImpl(
      httpService: container.resolve<HttpService>(),
    ),
  );

  //services
  container.registerSingleton<CongressmanService>(
    (container) => CongressmanServiceImpl(
      congressmanRepository: container.resolve<CongressmanRepository>(),
    ),
  );

  container.registerSingleton<CongressmanMoreInfoService>(
    (container) => CongressmanMoreInfoServiceImpl(
      congressmanMoreInfoRepository:
          container.resolve<CongressmanMoreInfoRepository>(),
    ),
  );
  //controllers
  container.registerFactory<SearchPageController>(
    (container) => SearchPageControllerImpl(
      congressmanService: container.resolve<CongressmanService>(),
    ),
  );

  container.registerFactory<FavoritesCongressmansListPageController>(
    (container) => FavoritesCongressmansListPageControllerImpl(
      congressmanService: container.resolve<CongressmanService>(),
    ),
  );

  container.registerFactory<CongressmanMoreInfoController>(
    (container) => CongressmanMoreInfoControllerImpl(
      congressmanMoreInfoService:
          container.resolve<CongressmanMoreInfoService>(),
    ),
  );

  runApp(const App());
}
