import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter_bloc_auth/repositories/auth_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription authSubscription;
  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    authSubscription = authRepository.user.listen((fbauth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });
    on<AuthStateChangedEvent>((event, emit) {
      if (event.user != null) {
        emit(state.copyWith(
            authstatus: AuthStatus.authenticated, user: event.user));
      } else {
        emit(
            state.copyWith(authstatus: AuthStatus.unauthenticated, user: null));
      }
    });

    on<SignOutRequested>((event, emit) async {
      await authRepository.signOut();
    });
  }
}
