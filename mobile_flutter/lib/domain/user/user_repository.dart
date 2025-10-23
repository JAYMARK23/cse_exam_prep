import 'package:dartz/dartz.dart';
import '../core/failure.dart';
import 'user.dart';
import 'user_role.dart';

abstract class UserRepository {
  /// Register a new user using Firebase Auth and create a profile in the backend if needed.
  /// Returns the created User on success or a Failure on error.
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });

  /// Sign in using Firebase Auth.
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Sign out from Firebase.
  Future<Either<Failure, void>> logout();

  /// Returns the currently authenticated user (if any).
  Future<Either<Failure, User>> getCurrentUser();

  /// Update profile fields for the current user.
  Future<Either<Failure, User>> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    UserRole? role,
  });
}
