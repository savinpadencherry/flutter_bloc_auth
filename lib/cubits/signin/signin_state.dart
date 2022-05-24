// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signin_cubit.dart';

enum SignInStatus { initial, error, submitting, success }

class SignInState extends Equatable {
  final SignInStatus signInStatus;
  final CustomError error;
  SignInState({
    required this.signInStatus,
    required this.error,
  });

  factory SignInState.initial() {
    return SignInState(
      signInStatus: SignInStatus.initial,
      error: CustomError(),
    );
  }

  @override
  bool get stringify => true;

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [signInStatus, error];
}
