import 'package:frontend_api_congressman/search/core/wrappers/result.dart';
import 'package:frontend_api_congressman/search/models/models.dart';

abstract class CongressmanRepository {
  Future<Result<List<CongressmanModel>>> getAllCongressmans();
}

class CongressmanRepositoryImpl implements CongressmanRepository {
  @override
  Future<Result<List<CongressmanModel>>> getAllCongressmans() async {
    try {
      return ResultSuccess([
        CongressmanModel(
          id: [],
          name: 'name',
          abbreviationFederalUnit: 'abbreviationFederalUnit',
          abbreviationGender: 'abbreviationGender',
          abbreviationPoliticalParty: 'abbreviationPoliticalParty',
          startDate: 'startDate',
        ),
        CongressmanModel(
          id: [22222],
          name: 'name22',
          abbreviationFederalUnit: 'abbreviationFederalUnit22',
          abbreviationGender: 'abbreviationGender22',
          abbreviationPoliticalParty: 'abbreviationPoliticalParty22',
          startDate: 'startDate22',
        ),
        CongressmanModel(
          id: [333333],
          name: 'name33',
          abbreviationFederalUnit: 'abbreviationFederalUnit33',
          abbreviationGender: 'abbreviationGender33',
          abbreviationPoliticalParty: 'abbreviationPoliticalParty332',
          startDate: 'startDate33',
        ),
      ]);
    } catch (e) {
      return ResultError(BaseError(message: 'Error loading congressmans list'));
    }
  }
}
