const String _appNameKey = "APP_NAME";
const String appName =
    String.fromEnvironment(_appNameKey, defaultValue: "Ninja Study");
const String _dbPathKey = "DB_PATH";
const String dbPath = String.fromEnvironment(_dbPathKey, defaultValue: "study");
