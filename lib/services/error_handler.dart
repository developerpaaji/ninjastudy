import 'package:logger/logger.dart';

abstract class ErrorHandler {
  void recordError(Object e, {StackTrace? stackTrace});
}

class LocalErrorHandler extends ErrorHandler {
  final logger = Logger();
  @override
  void recordError(Object e, {StackTrace? stackTrace}) {
    logger.e("Error Caught", e, stackTrace);
  }
}
