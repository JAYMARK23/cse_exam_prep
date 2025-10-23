import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../user_repository.dart';
import '../user.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.getCurrentUser();
  }
}
