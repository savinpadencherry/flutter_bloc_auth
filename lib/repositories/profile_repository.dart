// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc_auth/constants/constants.dart';
import 'package:flutter_bloc_auth/models/custom_error.dart';

import '../models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot documentSnapshot = await userRef.doc(uid).get();
      if (documentSnapshot.exists) {
        final currentUser = User.fromDocument(documentSnapshot);
        return currentUser;
      }
      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'Flutter_error/plugin_error');
    }
  }
}
