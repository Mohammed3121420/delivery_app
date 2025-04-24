import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel?> login({
    required String userId,
    required String password,
  }) async {
    return await remoteDataSource.login(
      userId: userId,
      password: password,
    );
  }
}
