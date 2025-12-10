import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import 'user_remote_data_source.dart';
import 'user_model.dart';
import '../../domain/user/user_role.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final fb_auth.FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.auth, required this.firestore});

  CollectionReference get _users => firestore.collection('users');

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user?.uid ?? '';
    final map = {
      'id': uid,
      'name': name,
      'email': email,
      'role': role.name,
      'phone': null,
      'avatarUrl': null,
    };
    await _users.doc(uid).set(map);
    return UserModel.fromMap(map);
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user?.uid ?? '';
    final snap = await _users.doc(uid).get();
    if (!snap.exists) {
      final map = {
        'id': uid,
        'name': credential.user?.displayName ?? '',
        'email': email,
        'role': UserRole.staff.name,
        'phone': null,
        'avatarUrl': null,
      };
      await _users.doc(uid).set(map);
      return UserModel.fromMap(map);
    }
    final data = snap.data() as Map<String, dynamic>;
    data['id'] = snap.id;
    return UserModel.fromMap(data);
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final u = auth.currentUser;
    if (u == null) throw Exception('No authenticated user');
    final snap = await _users.doc(u.uid).get();
    if (!snap.exists) throw Exception('User profile not found');
    final data = snap.data() as Map<String, dynamic>;
    data['id'] = snap.id;
    return UserModel.fromMap(data);
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    UserRole? role,
  }) async {
    final docRef = _users.doc(userId);
    final update = <String, dynamic>{};
    if (name != null) update['name'] = name;
    if (phone != null) update['phone'] = phone;
    if (avatarUrl != null) update['avatarUrl'] = avatarUrl;
    if (role != null) update['role'] = role.name;
    if (update.isNotEmpty) await docRef.update(update);
    final snap = await docRef.get();
    if (!snap.exists) throw Exception('User not found');
    final data = snap.data() as Map<String, dynamic>;
    data['id'] = snap.id;
    return UserModel.fromMap(data);
  }
}
