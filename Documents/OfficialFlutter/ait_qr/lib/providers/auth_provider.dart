import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> signIn(UserModel user) async {
    var result = await _authService.signIn(user);
    if (result != null) {
      _user = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
