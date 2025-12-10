import 'package:dartz/dartz.dart';

import '../../domain/core/failure.dart';
import '../../domain/user/user.dart';
import '../../domain/user/user_role.dart';
import '../../domain/user/user_repository.dart';
import '../core/data_failure.dart';
import 'user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  UserRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    try {
      final model = await remote.register(
        name: name,
        email: email,
        password: password,
        role: role,
      );
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await remote.login(email: email, password: password);
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remote.logout();
      return const Right(null);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final model = await remote.getCurrentUser();
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    UserRole? role,
  }) async {
    try {
      final model = await remote.updateProfile(
        userId: userId,
        name: name,
        phone: phone,
        avatarUrl: avatarUrl,
        role: role,
      );
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }
}
