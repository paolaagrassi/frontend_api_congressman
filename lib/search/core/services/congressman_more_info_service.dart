// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:frontend_api_congressman/search/core/repositories/congressman_more_info_repository.dart';
import 'package:frontend_api_congressman/search/core/wrappers/result.dart';
import 'package:frontend_api_congressman/search/models/models.dart';

abstract class CongressmanMoreInfoService {
  Future<Result<CongressmanMoreInfoModel>> getCongressmanInfo({
    required String? id,
  });
}

class CongressmanMoreInfoServiceImpl implements CongressmanMoreInfoService {
  final CongressmanMoreInfoRepository congressmanMoreInfoRepository;

  CongressmanMoreInfoServiceImpl({
    required this.congressmanMoreInfoRepository,
  });

  @override
  Future<Result<CongressmanMoreInfoModel>> getCongressmanInfo({
    required String? id,
  }) async {
    final result =
        await congressmanMoreInfoRepository.getCongressmanInfo(id: id);

    return result;
  }
}
