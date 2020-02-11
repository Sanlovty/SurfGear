import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/base_strategy_factory.dart';
import 'package:ci/tasks/handler_error/error_handler.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  final BaseStrategyFactory _baseStrategyFactory;

  StandardErrorHandler(this._baseStrategyFactory);

  Future<void> _baseError(BaseCiException error) async {
    var fun = _baseStrategyFactory.handleError(error);
    await fun(error);
  }

  Future<void> _unknownError(Exception error) async {
    var fun = _baseStrategyFactory.unknownError();
    await fun(error);
  }

  @override
  Future<void> handler(Exception exception) async {
    if (exception is BaseCiException) {
      await _baseError(exception);
    } else {
      await _unknownError(exception);
    }
  }
}
