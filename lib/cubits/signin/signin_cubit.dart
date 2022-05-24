import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_auth/models/custom_error.dart';
import 'package:flutter_bloc_auth/repositories/auth_repositories.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  SigninCubit({required this.authRepository}) : super(SignInState.initial());

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(signInStatus: SignInStatus.submitting));
    try {
      await authRepository.signIn(email: email, password: password);
      emit(state.copyWith(signInStatus: SignInStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(signInStatus: SignInStatus.error, error: e),
      );
    }
  }
}
