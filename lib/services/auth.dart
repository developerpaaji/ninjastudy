import 'package:shared_preferences/shared_preferences.dart';
import 'package:study/models/response.dart';
import 'package:study/models/user.dart';
import 'package:study/services/base.dart';
import 'package:study/services/database.dart';
import 'package:uuid/uuid.dart';

class WrongPasswordError extends Error {
  @override
  String toString() => "Wrong password";
}

typedef UserResponse = ApiResponse<User>;

const String currentUserKey = "currentUser";

class AuthService extends BaseService {
  final NoSQLDB db;
  final SharedPreferences sharedPreferences;

  AuthService(this.db, this.sharedPreferences);

  Future<UserResponse> signin(String username, String password) async {
    try {
      final oldUserJson = await db.findOne(EqualQuery("username", username));
      if (oldUserJson == null) {
        User newUser =
            await _createUser(username.toLowerCase().trim(), password);
        await _save(newUser.id);
        return ApiResponse(data: newUser);
      }
      final oldUser = User.fromJson(oldUserJson);
      if (oldUser.password != password) {
        throw WrongPasswordError();
      }
      await _save(oldUser.id);
      return ApiResponse(data: oldUser);
    } catch (e) {
      return ApiResponse(error: e);
    }
  }

  Future<void> _save(String userId) async {
    await sharedPreferences.setString(currentUserKey, userId);
  }

  Future<User> _createUser(String username, String password) async {
    final User newUser = User(
        id: const Uuid().v4(),
        username: username,
        createdAt: DateTime.now(),
        password: password);
    await db.save(newUser.id, newUser.toJson());
    return newUser;
  }

  Future<VoidResponse> logout() async {
    try {
      await sharedPreferences.remove(currentUserKey);
      return VoidResponse();
    } catch (e) {
      return VoidResponse(error: e);
    }
  }

  Future<User?> get currentUser async {
    final result = sharedPreferences.getString(currentUserKey);
    if (result == null) {
      return null;
    }
    final userJson = await db.get(result);
    return userJson != null ? User.fromJson(userJson) : null;
  }
}
