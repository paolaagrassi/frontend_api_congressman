import 'package:flutter/material.dart';
import 'package:frontend_api_congressman/app.dart';
import 'package:frontend_api_congressman/search/controllers/search_page_controller.dart';
import 'package:frontend_api_congressman/search/core/repositories/repositories.dart';
import 'package:frontend_api_congressman/search/core/services/congressman_service.dart';
import 'package:kiwi/kiwi.dart';

void main() {
  final KiwiContainer container = KiwiContainer();

  //repositories
  container.registerSingleton<CongressmanRepository>(
    (container) => CongressmanRepositoryImpl(),
  );

  //services
  container.registerSingleton<CongressmanServices>(
    (container) => CongressmanServicesImpl(
      congressmanRepository: container.resolve<CongressmanRepository>(),
    ),
  );
  //controllers
  container.registerFactory<SearchPageController>(
    (container) => SearchPageControllerImpl(
      congressmanService: container.resolve<CongressmanServices>(),
    ),
  );

  runApp(const App());
}
