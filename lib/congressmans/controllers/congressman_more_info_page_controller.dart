// ignore_for_file: public_member_api_docs, sort_constructors_first, always_use_package_imports
import 'package:frontend_api_congressman/congressmans/core/services/services.dart';
import 'package:frontend_api_congressman/congressmans/core/wrappers/result.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';

import '../models/models.dart';

abstract class CongressmanMoreInfoController extends BaseController {
  Future<Result<CongressmanMoreInfoModel>> getMoreInformation({
    required String? id,
  });
}

class CongressmanMoreInfoControllerImpl
    implements CongressmanMoreInfoController {
  final CongressmanService congressmanService;

  CongressmanMoreInfoControllerImpl({
    required this.congressmanService,
  });

  @override
  Future<Result<CongressmanMoreInfoModel>> getMoreInformation({
    required String? id,
  }) async {
    final result = await congressmanService.getCongressmanMoreInfo(id: id);

    return result;
  }
}
