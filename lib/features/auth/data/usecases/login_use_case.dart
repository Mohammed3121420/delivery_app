import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel?> execute({
    required String userId,
    required String password,
  }) {
    return repository.login(
      userId: userId,
      password: password,
    );
  }
}
