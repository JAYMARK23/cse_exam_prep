import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../user_repository.dart';
import '../user.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
