import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/models/user.dart';
import 'package:study/services/auth.dart';

abstract class AuthState {}

class AuthIdleState extends AuthState {}

class AuthSuccessState extends AuthState {
  final User user;
  AuthSuccessState(
    this.user,
  );
}

class AuthLoggedOutState extends AuthState {}

class AuthBloc extends Cubit<AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthIdleState());

  Future<void> init() async {
    final currentUser = await authService.currentUser;
    if (currentUser != null) {
      emit(AuthSuccessState(currentUser));
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
