import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_auth/models/custom_error.dart';
import 'package:flutter_bloc_auth/repositories/auth_repositories.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit({required this.authRepository}) : super(SignupState.initial());

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
    try {
      await authRepository.signUp(name: name, email: email, password: password);
      emit(state.copyWith(signUpStatus: SignUpStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signUpStatus: SignUpStatus.error,
          error:
              CustomError(code: e.code, message: e.message, plugin: e.plugin),
        ),
      );
    }
  }
}
