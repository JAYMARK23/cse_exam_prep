import '../../domain/user/user.dart';
import '../../domain/user/user_role.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    String? phone,
    String? avatarUrl,
  }) : super(
          id: id,
          name: name,
          email: email,
          role: role,
          phone: phone,
          avatarUrl: avatarUrl,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? map['uid'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      role: UserRoleX.fromString((map['role'] ?? 'staff') as String),
      phone: map['phone'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'phone': phone,
      'avatarUrl': avatarUrl,
    };
    return map;
  }
}
