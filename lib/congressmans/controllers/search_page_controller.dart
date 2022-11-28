// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend_api_congressman/congressmans/core/services/congressman_service.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

abstract class SearchPageController extends BaseController {
  List<CongressmanModel> favoritedCongressmansList = [];

  Future<List<CongressmanModel>> getAllCongressmans();

  List<CongressmanModel> filterList(String searchText);

  List<CongressmanModel> getMoreDataByCount(int count);

  bool isCongressmanFavorited(CongressmanModel congressmanModel);

  late TextEditingController queryTextEditingController =
      TextEditingController();

  Future<List<CongressmanModel>> getFavoritedList();

  Future<bool> saveCongressmanToStorage(
    CongressmanModel congressman,
  );
}

class SearchPageControllerImpl implements SearchPageController {
  final CongressmanService congressmanService;

  final listMaximumRange = 90;

  @override
  late TextEditingController queryTextEditingController =
      TextEditingController();

  List<CongressmanModel> congressmanList = [];

  @override
  List<CongressmanModel> favoritedCongressmansList = [];

  SearchPageControllerImpl({
    required this.congressmanService,
  });

  @override
  Future<List<CongressmanModel>> getAllCongressmans() async {
    await getFavoritedList();
    final result = await congressmanService.getAllCongressmans();

    if (result.isSuccess) {
      congressmanList = result.extractSuccess;
    }

    return result.isSuccess
        ? result.extractSuccess.getRange(0, listMaximumRange).toList()
        : [];
  }

  @override
  List<CongressmanModel> filterList(String searchText) {
    return congressmanList
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()) ||
              element.abbreviationPoliticalParty.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
        )
        .toList();
  }

  @override
  List<CongressmanModel> getMoreDataByCount(int count) {
    final viewList = congressmanList.getRange(0, count).toList();

    viewList.addAll(congressmanList.getRange(count, count + listMaximumRange));

    return viewList;
  }

  @override
  Future<List<CongressmanModel>> getFavoritedList() async {
    final result =
        await congressmanService.getFavoritedCongressmanFromStorage();

    if (result.isSuccess) {
      favoritedCongressmansList = result.extractSuccess;
    }

    return result.isSuccess ? result.extractSuccess : [];
  }

  @override
  Future<bool> saveCongressmanToStorage(
    CongressmanModel congressman,
  ) async {
    if (isCongressmanFavorited(congressman)) {
      favoritedCongressmansList
          .removeWhere((element) => element.name == congressman.name);
    } else {
      favoritedCongressmansList.add(congressman);
    }

    final result = await congressmanService
        .saveCongressmanToStorage(favoritedCongressmansList);

    return result.isSuccess;
  }

  @override
  bool isCongressmanFavorited(CongressmanModel congressmanModel) {
    return favoritedCongressmansList
        .where((element) => element.name == congressmanModel.name)
        .isNotEmpty;
  }
}
