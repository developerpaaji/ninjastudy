import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/models/user.dart';
import 'package:study/services/auth.dart';

abstract class AuthState {}

class AuthIdleState {}

class AuthSuccessState extends AuthState {
  final User user;
  AuthSuccessState(
    this.user,
  );
}

class AuthLoggedOutState extends AuthState {}

class AuthBloc extends Cubit<AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthLoggedOutState());

  Future<void> init() async {
    if (authService.currentUser != null) {
      emit(AuthSuccessState(authService.currentUser!));
      return;
    } else {
      emit(AuthLoggedOutState());
    }
  }

  Future<dynamic> signin(String username, String password) async {
    final response = await authService.signin(username, password);
    if (response.isSuccess) {
      emit(AuthSuccessState(response.data!));
    } else {
      return response.error;
    }
  }

  Future<dynamic> logout() async {
    final response = await authService.logout();
    if (response.isSuccess) {
      emit(AuthLoggedOutState());
    } else {
      return response.error;
    }
  }
}
