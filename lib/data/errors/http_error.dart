import '../../domain/errors/errors.dart';

sealed class HttpError implements Exception {
  const HttpError._({this.message = '', this.detail = ''});

  final String message;
  final String detail;

  factory HttpError.badRequest({String message = '', String detail = ''}) =>
      _BadRequest(message: message, detail: detail);
  factory HttpError.unauthorized({String message = '', String detail = ''}) =>
      _Unauthorized(message: message, detail: detail);
  factory HttpError.forbidden({String message = '', String detail = ''}) =>
      _Forbidden(message: message, detail: detail);
  factory HttpError.notFound({String message = '', String detail = ''}) => _NotFound(message: message, detail: detail);
  factory HttpError.invalidData({String message = '', String detail = ''}) =>
      _InvalidData(message: message, detail: detail);
  factory HttpError.timeOut({String message = '', String detail = ''}) => _TimeOut(message: message, detail: detail);
  factory HttpError.serverError({String message = '', String detail = ''}) =>
      _ServerError(message: message, detail: detail);
  factory HttpError.noConnectionError({String message = '', String detail = ''}) =>
      _NoConnectionError(message: message, detail: detail);
  factory HttpError.attemptsExceeded({String message = '', String detail = ''}) =>
      _AttemptsExceededError(message: message, detail: detail);
  factory HttpError.unexpected({String message = '', String detail = ''}) =>
      _UnexpectedError(message: message, detail: detail);
}

final class _BadRequest extends HttpError implements InvalidDataError {
  const _BadRequest({super.message, super.detail}) : super._();
}

final class _Unauthorized extends HttpError implements UnauthorizedError {
  const _Unauthorized({super.message, super.detail}) : super._();
}

final class _Forbidden extends HttpError implements UnauthorizedError {
  const _Forbidden({super.message, super.detail}) : super._();
}

final class _NotFound extends HttpError implements NotFoundError {
  _NotFound({super.message, super.detail}) : super._();
}

final class _InvalidData extends HttpError implements InvalidDataError {
  _InvalidData({super.message, super.detail}) : super._();
}

final class _TimeOut extends HttpError implements TimeOutError {
  _TimeOut({super.message, super.detail}) : super._();
}

final class _ServerError extends HttpError implements ApiError {
  _ServerError({super.message, super.detail}) : super._();
}

final class _NoConnectionError extends HttpError implements NoConnectionError {
  _NoConnectionError({super.message, super.detail}) : super._();
}

final class _AttemptsExceededError extends HttpError implements AttemptsExceededError {
  _AttemptsExceededError({super.message, super.detail}) : super._();
}

final class _UnexpectedError extends HttpError implements UnexpectedError {
  _UnexpectedError({super.message, super.detail}) : super._();
}
