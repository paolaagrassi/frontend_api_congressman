class Result<Success> {
  Success? _success;
  BaseError? _error;

  Result(Object object) {
    if (object is Success) {
      _success = object as Success;
    } else {
      _error = object as BaseError;
    }
  }

  bool get isSuccess => _success != null;

  bool get isError => _error != null;

  Success get extractSuccess => _success!;

  BaseError get extractError => _error!;
}

class ResultSuccess<S> extends Result<S> {
  ResultSuccess(S success) : super(success!);
}

class ResultError<E> extends Result<E> {
  ResultError(BaseError super.error);
}

class BaseError extends Error {
  String message;

  BaseError({
    required this.message,
  });
}
