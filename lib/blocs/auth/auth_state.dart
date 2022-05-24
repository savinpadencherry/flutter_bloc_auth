// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus authstatus;
  final fbauth.User? user;
  AuthState({
    required this.authstatus,
    this.user,
  });

  factory AuthState.initial() {
    return AuthState(authstatus: AuthStatus.unknown);
  }

  @override
  bool get stringify => true;

  AuthState copyWith({
    AuthStatus? authstatus,
    fbauth.User? user,
  }) {
    return AuthState(
      authstatus: authstatus ?? this.authstatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [authstatus, user];
}
