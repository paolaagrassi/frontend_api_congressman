import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_api_congressman/app.dart';
import 'package:frontend_api_congressman/congressmans/controllers/controllers.dart';
import 'package:frontend_api_congressman/congressmans/core/clients/clients.dart';
import 'package:frontend_api_congressman/congressmans/core/repositories/repositories.dart';
import 'package:frontend_api_congressman/congressmans/core/services/services.dart';
import 'package:kiwi/kiwi.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Permission.storage.request().isGranted) {
    final KiwiContainer container = KiwiContainer();

    final Dio dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        maxWidth: 120,
      ),
    );

    final localStorage = LocalStorage('application.json');

    await localStorage.ready;

    //clients
    container.registerSingleton<HttpClient>(
      (container) => DioClient(dio),
    );

    container.registerSingleton<LocalStorageClient>(
      (container) => StorageClientImpl(localStorage),
    );

    //repositories
    container.registerSingleton<CongressmanRepository>(
      (container) => CongressmanRepositoryImpl(
        httpClient: container.resolve<HttpClient>(),
        localStorage: container.resolve<LocalStorageClient>(),
      ),
    );

    //services
    container.registerSingleton<CongressmanService>(
      (container) => CongressmanServiceImpl(
        congressmanRepository: container.resolve<CongressmanRepository>(),
      ),
    );

    //controllers
    container.registerFactory<SearchPageController>(
      (container) => SearchPageControllerImpl(
        congressmanService: container.resolve<CongressmanService>(),
      ),
    );

    container.registerFactory<FavoritesPageController>(
      (container) => FavoritesPageControllerImpl(
        congressmanService: container.resolve<CongressmanService>(),
      ),
    );

    container.registerFactory<CongressmanMoreInfoController>(
      (container) => CongressmanMoreInfoControllerImpl(
        congressmanService: container.resolve<CongressmanService>(),
      ),
    );

    runApp(const App());
  }
}
