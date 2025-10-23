import 'package:equatable/equatable.dart';
import 'user_role.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? phone;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.avatarUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? phone,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'phone': phone,
      'avatarUrl': avatarUrl,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRoleX.fromString(json['role'] as String),
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, email, role, phone, avatarUrl];
}
