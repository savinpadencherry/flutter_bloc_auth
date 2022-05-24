// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter_bloc_auth/constants/constants.dart';
import 'package:flutter_bloc_auth/models/custom_error.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbauth.FirebaseAuth firebaseAuth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fbauth.User?> get user => firebaseAuth.userChanges();

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final fbauth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final signedInUser = userCredential.user!;
      await userRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'userProfileImg': '',
        'point': 0,
        'rank': 'bronze',
      });
    } on fbauth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fbauth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'Flutter_error/server_error',
      );
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
