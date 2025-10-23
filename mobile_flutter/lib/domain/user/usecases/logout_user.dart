import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../user_repository.dart';

class LogoutUser {
  final UserRepository repository;

  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
