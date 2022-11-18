// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:frontend_api_congressman/search/core/services/congressman_service.dart';
import 'package:frontend_api_congressman/search/models/models.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

abstract class SearchPageController extends BaseController {
  Future<List<CongressmanModel>> getAllCongressmans();
}

class SearchPageControllerImpl implements SearchPageController {
  final CongressmanServices congressmanService;

  SearchPageControllerImpl({
    required this.congressmanService,
  });

  @override
  Future<List<CongressmanModel>> getAllCongressmans() async {
    final result = await congressmanService.getAllCongressmans();

    return result.isSuccess ? result.extractSuccess : [];
  }
}
