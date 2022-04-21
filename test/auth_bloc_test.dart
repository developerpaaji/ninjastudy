import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/services/auth.dart';
import 'package:study/services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NoSQLDB db = MockDB();
  SharedPreferences.setMockInitialValues({});
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AuthService authService = AuthService(db, sharedPreferences);

  AuthBloc authBloc = AuthBloc(authService);

  test("Auth idle  state initially", () async {
    expect(authBloc.state is AuthIdleState, true);
  });

  test("Auth logged out state after init", () async {
    await authBloc.init();
    expect(authBloc.state is AuthLoggedOutState, true);
  });

  test("Auth logged in state ", () async {
    dynamic error = await authBloc.signin("singhbhavneet", "password");
    if (error == null) {
      expect(authBloc.state is AuthSuccessState, true);
      final user = (authBloc.state as AuthSuccessState).user;
      expect(user.username, "singhbhavneet");
    } else {
      throw error;
    }
  });

  test("Auth still in same state if init called in between", () async {
    await authBloc.init();
    expect(authBloc.state is AuthSuccessState, true);
  });

  test("Auth logged out state ", () async {
    final error = await authBloc.logout();
    // no matter what auth always logout
    if (error == null) {
      expect(authBloc.state is AuthLoggedOutState, true);
    } else {
      throw error;
    }
  });

  test("User try with wrong password", () async {
    final error = await authBloc.signin("singhbhavneet", "password1");
    expect(error is WrongPasswordError, true);
  });

  test("User try with right password", () async {
    final error = await authBloc.signin("singhbhavneet", "password");
    if (error == null) {
      expect(authBloc.state is AuthSuccessState, true);
    } else {
      throw error;
    }
  });
}
