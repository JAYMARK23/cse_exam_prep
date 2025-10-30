import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:dartz/dartz.dart';

import '../../domain/core/failure.dart';
import '../../domain/user/user.dart';
import '../../domain/user/user_role.dart';
import '../../domain/user/user_repository.dart';
import '../core/data_failure.dart';
import 'user_model.dart';

class FirebaseUserRepository implements UserRepository {
  final fb.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseUserRepository(this._auth, this._firestore);

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User? fbUser = credential.user;
      if (fbUser == null) return Left(DataFailure('Failed to create user'));

      final userModel = UserModel(
        id: fbUser.uid,
        name: name,
        email: email,
        role: role,
      );
      await _firestore.collection('users').doc(fbUser.uid).set(userModel.toMap());
      return Right(userModel);
    } on fb.FirebaseAuthException catch (e) {
      return Left(DataFailure(e.message ?? 'Auth error'));
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
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User? fbUser = credential.user;
      if (fbUser == null) return Left(DataFailure('Failed to sign in'));

      final snapshot = await _firestore.collection('users').doc(fbUser.uid).get();
      if (!snapshot.exists) {
        final userModel = UserModel(
          id: fbUser.uid,
          name: fbUser.displayName ?? '',
          email: email,
          role: UserRole.staff,
        );
        await _firestore.collection('users').doc(fbUser.uid).set(userModel.toMap());
        return Right(userModel);
      }

      final map = snapshot.data()!;
      map['id'] = fbUser.uid;
      final userModel = UserModel.fromMap(map);
      return Right(userModel);
    } on fb.FirebaseAuthException catch (e) {
      return Left(DataFailure(e.message ?? 'Auth error'));
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _auth.signOut();
      return Right(null);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final fb.User? fbUser = _auth.currentUser;
      if (fbUser == null) return Left(DataFailure('No user logged in'));

      final snapshot = await _firestore.collection('users').doc(fbUser.uid).get();
      if (!snapshot.exists) return Left(DataFailure('No profile found'));

      final map = snapshot.data()!;
      map['id'] = fbUser.uid;
      final userModel = UserModel.fromMap(map);
      return Right(userModel);
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
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (phone != null) updates['phone'] = phone;
      if (avatarUrl != null) updates['avatarUrl'] = avatarUrl;
      if (role != null) updates['role'] = role.name;

      await _firestore.collection('users').doc(userId).update(updates);
      final snapshot = await _firestore.collection('users').doc(userId).get();
      final map = snapshot.data()!;
      map['id'] = userId;
      final userModel = UserModel.fromMap(map);
      return Right(userModel);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }
}
