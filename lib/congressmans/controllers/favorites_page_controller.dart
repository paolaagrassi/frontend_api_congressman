import 'package:frontend_api_congressman/congressmans/core/services/services.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

abstract class FavoritesPageController extends BaseController {
  Future<List<CongressmanModel>> saveCongressmanToStorage(
    List<CongressmanModel> congressmanList,
    CongressmanModel congressmanModel,
  );
}

class FavoritesPageControllerImpl extends FavoritesPageController {
  final CongressmanService congressmanService;

  FavoritesPageControllerImpl({
    required this.congressmanService,
  });

  @override
  Future<List<CongressmanModel>> saveCongressmanToStorage(
    List<CongressmanModel> congressmanList,
    CongressmanModel congressmanModel,
  ) async {
    congressmanList
        .removeWhere((element) => element.name == congressmanModel.name);

    congressmanService.saveCongressmanToStorage(congressmanList);

    return congressmanList;
  }
}
