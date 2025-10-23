import 'package:equatable/equatable.dart';

/// Roles used in MVP: Owner (store owner) and Staff (store employee)
enum UserRole { owner, staff }

extension UserRoleX on UserRole {
  String get name {
    switch (this) {
      case UserRole.owner:
        return 'owner';
      case UserRole.staff:
        return 'staff';
    }
  }

  static UserRole fromString(String s) {
    switch (s.toLowerCase()) {
      case 'owner':
        return UserRole.owner;
      case 'staff':
        return UserRole.staff;
      default:
        return UserRole.staff; // default fallback
    }
  }
}
