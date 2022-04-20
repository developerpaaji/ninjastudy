import 'package:get_it/get_it.dart';
import 'package:study/client.dart';
import 'package:study/config/api.dart';
import 'package:study/services/auth.dart';
import 'package:study/services/conversation.dart';
import 'package:study/services/error_handler.dart';

bool _isSetup = false;
late GetIt locator;

setupLocator() async {
  if (!_isSetup) {
    locator = GetIt.instance;
    // Error Handler
    ErrorHandler errorHandler = LocalErrorHandler();
    locator.registerSingleton<ErrorHandler>(errorHandler);
    // Client
    ApiClient client = ApiClient(baseUrl: apiBaseUrl);
    locator.registerSingleton<ApiClient>(client);
    // Auth Service
    locator.registerSingleton<AuthService>(AuthService());
    // Conversation
    locator.registerSingleton<ConversationService>(
        ConversationService(client, errorHandler));
    _isSetup = true;
  }
}
