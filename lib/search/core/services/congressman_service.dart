// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:frontend_api_congressman/search/core/repositories/congressman_repository.dart';
import 'package:frontend_api_congressman/search/core/wrappers/result.dart';
import 'package:frontend_api_congressman/search/models/models.dart';

abstract class CongressmanServices {
  Future<Result<List<CongressmanModel>>> getAllCongressmans();
}

class CongressmanServicesImpl implements CongressmanServices {
  CongressmanServicesImpl({
    required this.congressmanRepository,
  });

  final CongressmanRepository congressmanRepository;

  @override
  Future<Result<List<CongressmanModel>>> getAllCongressmans() async {
    final result = await congressmanRepository.getAllCongressmans();

    return result;
  }
}
