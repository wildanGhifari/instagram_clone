import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  // Method to get user.
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
