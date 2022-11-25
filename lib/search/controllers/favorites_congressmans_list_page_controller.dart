import 'package:frontend_api_congressman/search/core/services/services.dart';
import 'package:frontend_api_congressman/search/models/models.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

abstract class FavoritesCongressmansListPageController extends BaseController {
  Future<List<CongressmanModel>> getAllCongressmans();
}

class FavoritesCongressmansListPageControllerImpl
    extends FavoritesCongressmansListPageController {
  final CongressmanService congressmanService;

  FavoritesCongressmansListPageControllerImpl({
    required this.congressmanService,
  });

  @override
  Future<List<CongressmanModel>> getAllCongressmans() async {
    final result = await congressmanService.getAllCongressmans();

    return result.isSuccess ? result.extractSuccess : [];
  }
}
