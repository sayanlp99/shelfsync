import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthService {
  Future<ParseUser?> signUp(
    String username,
    String password,
    String email,
  ) async {
    final user = ParseUser(username, password, email);
    final response = await user.signUp();
    if (response.success) {
      return user;
    } else {
      throw Exception(response.error?.message);
    }
  }

  Future<ParseUser?> login(String username, String password) async {
    final user = ParseUser(username, password, null);
    final response = await user.login();
    if (response.success) {
      return user;
    } else {
      throw Exception(response.error?.message);
    }
  }

  Future<void> logout() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      await user.logout();
    }
  }

  Future<bool> hasUserLoggedIn() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user == null) {
      return false;
    }
    final response = await ParseUser.getCurrentUserFromServer(
      user.sessionToken!,
    );
    return response!.success;
  }
}
