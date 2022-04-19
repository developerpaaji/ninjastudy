import 'package:flutter_test/flutter_test.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/services/auth.dart';

void main() {
  AuthService authService = AuthService();

  AuthBloc authBloc = AuthBloc(authService);
  test("Auth logged out state initially", () async {
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
}
