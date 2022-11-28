import 'package:frontend_api_congressman/congressmans/core/repositories/congressman_repository.dart';
import 'package:frontend_api_congressman/congressmans/core/wrappers/result.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';

abstract class CongressmanService {
  Future<Result<List<CongressmanModel>>> getAllCongressmans();

  Future<Result<CongressmanMoreInfoModel>> getCongressmanMoreInfo({
    required String? id,
  });

  Future<Result<bool>> saveCongressmanToStorage(
    List<CongressmanModel> congressmanList,
  );

  Future<Result<List<CongressmanModel>>> getFavoritedCongressmanFromStorage();
}

class CongressmanServiceImpl implements CongressmanService {
  CongressmanServiceImpl({
    required this.congressmanRepository,
  });

  final CongressmanRepository congressmanRepository;

  @override
  Future<Result<List<CongressmanModel>>> getAllCongressmans() async {
    final result = await congressmanRepository.getAllCongressmans();

    return result;
  }

  @override
  Future<Result<CongressmanMoreInfoModel>> getCongressmanMoreInfo({
    required String? id,
  }) async {
    final result = await congressmanRepository.getCongressmanMoreInfo(id: id);

    return result;
  }

  @override
  Future<Result<bool>> saveCongressmanToStorage(
    List<CongressmanModel> congressmanList,
  ) async {
    final result =
        await congressmanRepository.saveAllFavoritedCongressmanToLocalStorage(
      congressmanList,
    );

    return result;
  }

  @override
  Future<Result<List<CongressmanModel>>>
      getFavoritedCongressmanFromStorage() async {
    final result =
        await congressmanRepository.getFavoritedCongressmanFromStorage();

    return result;
  }
}
