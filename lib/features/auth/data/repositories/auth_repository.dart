import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> login({
    required String userId,
    required String password,
  });
}
