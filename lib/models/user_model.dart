// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String userProfileImg;
  final int point;
  final String rank;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.userProfileImg,
    required this.point,
    required this.rank,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      userProfileImg,
      point,
      rank,
    ];
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final userData = doc.data() as Map<String, dynamic>?;
    return User(
        id: doc.id,
        name: userData!['name'],
        email: userData['email'],
        userProfileImg: userData['userProfileImg'],
        point: userData['point'],
        rank: userData['rank']);
  }

  factory User.initial() {
    return User(
        id: '', name: '', email: '', userProfileImg: '', point: 0, rank: '');
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? userProfileImg,
    int? point,
    String? rank,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userProfileImg: userProfileImg ?? this.userProfileImg,
      point: point ?? this.point,
      rank: rank ?? this.rank,
    );
  }

  @override
  bool get stringify => true;
}
