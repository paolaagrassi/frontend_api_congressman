// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend_api_congressman/search/core/services/congressman_service.dart';
import 'package:frontend_api_congressman/search/models/models.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

abstract class SearchPageController extends BaseController {
  Future<List<CongressmanModel>> getAllCongressmans();

  List<CongressmanModel> filterList(String searchText);

  List<CongressmanModel> getMoreDataByCount(int count);

  late TextEditingController queryTextEditingController =
      TextEditingController();
}

class SearchPageControllerImpl implements SearchPageController {
  final CongressmanService congressmanService;

  final listMaximumRange = 20;

  @override
  late TextEditingController queryTextEditingController =
      TextEditingController();

  List<CongressmanModel> congressmanList = [];

  SearchPageControllerImpl({
    required this.congressmanService,
  });

  @override
  Future<List<CongressmanModel>> getAllCongressmans() async {
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
}
