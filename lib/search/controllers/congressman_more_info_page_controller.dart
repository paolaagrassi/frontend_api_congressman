// ignore_for_file: public_member_api_docs, sort_constructors_first, always_use_package_imports
import 'package:frontend_api_congressman/search/core/services/congressman_more_info_service.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

import '../models/models.dart';

abstract class CongressmanMoreInfoController extends BaseController {
  Future<CongressmanMoreInfoModel> getMoreInformation({
    required String? id,
  });
}

class CongressmanMoreInfoControllerImpl
    implements CongressmanMoreInfoController {
  final CongressmanMoreInfoService congressmanMoreInfoService;

  CongressmanMoreInfoControllerImpl({
    required this.congressmanMoreInfoService,
  });

  @override
  Future<CongressmanMoreInfoModel> getMoreInformation({
    required String? id,
  }) async {
    final result = await congressmanMoreInfoService.getCongressmanInfo(id: id);

    return result.isSuccess
        ? result.extractSuccess
        : CongressmanMoreInfoModel(
            education: '',
            birthCity: '',
            abbreviationGender: '',
          );
  }
}
