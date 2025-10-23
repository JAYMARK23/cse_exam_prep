import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../user_repository.dart';
import '../user.dart';
import '../user_role.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    return await repository.register(name: name, email: email, password: password, role: role);
  }
}
