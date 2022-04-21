import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study/client.dart';
import 'package:study/config/api.dart';
import 'package:study/config/app.dart';
import 'package:study/services/auth.dart';
import 'package:study/services/conversation.dart';
import 'package:study/services/database.dart';
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
    NoSQLDB db = SembastDB(dbPath);
    await db.open();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    locator.registerSingleton<AuthService>(AuthService(db, sharedPreferences));
    // Conversation
    ConversationService conversationService =
        ConversationApiService(client, errorHandler);
    locator.registerSingleton<ConversationService>(conversationService);
    _isSetup = true;
  }
}
