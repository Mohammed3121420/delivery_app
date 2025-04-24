import 'package:flutter/material.dart';
import '../usecases/login_use_case.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;

  AuthProvider(this.loginUseCase);

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> login(String userId, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await loginUseCase.execute(
      userId: userId,
      password: password,
    );

    _user = result;
    _isLoading = false;
    notifyListeners();
  }
}
