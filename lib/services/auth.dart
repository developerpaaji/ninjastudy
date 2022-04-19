import 'package:study/models/response.dart';
import 'package:study/models/user.dart';
import 'package:study/services/base.dart';
import 'package:uuid/uuid.dart';

typedef UserResponse = ApiResponse<User>;

class AuthService extends BaseService {
  User? _currentUser;

  Future<UserResponse> signin(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final User newUser = User(
      id: const Uuid().v4(),
      username: username,
      createdAt: DateTime.now(),
    );
    _currentUser = newUser;
    return ApiResponse(data: newUser);
  }

  Future<VoidResponse> logout() async {
    _currentUser = null;
    return VoidResponse();
  }

  User? get currentUser => _currentUser;
}
