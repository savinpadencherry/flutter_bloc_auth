// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signup_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignUpStatus signUpStatus;
  final CustomError error;
  SignupState({
    required this.signUpStatus,
    required this.error,
  });

  factory SignupState.initial() {
    return SignupState(
        signUpStatus: SignUpStatus.initial, error: CustomError());
  }

  @override
  List<Object> get props => [signUpStatus, error];

  SignupState copyWith({
    SignUpStatus? signUpStatus,
    CustomError? error,
  }) {
    return SignupState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
