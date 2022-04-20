import 'package:study/services/error_handler.dart';

abstract class BaseService {
  final ErrorHandler? errorHandler;

  BaseService([this.errorHandler]);
}
