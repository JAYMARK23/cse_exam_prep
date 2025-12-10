import '../../domain/user/user_role.dart';

import 'user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();

  Future<UserModel> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    UserRole? role,
  });
}
