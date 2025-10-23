import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../user_repository.dart';
import '../user.dart';
import '../user_role.dart';

class UpdateProfile {
  final UserRepository repository;

  UpdateProfile(this.repository);

  Future<Either<Failure, User>> call({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    UserRole? role,
  }) async {
    return await repository.updateProfile(userId: userId, name: name, phone: phone, avatarUrl: avatarUrl, role: role);
  }
}
