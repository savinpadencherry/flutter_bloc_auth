// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

enum ProfileStatus {
  intial,
  loading,
  loaded,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final CustomError customError;
  ProfileState({
    required this.profileStatus,
    required this.user,
    required this.customError,
  });

  factory ProfileState.initial() {
    return ProfileState(
        profileStatus: ProfileStatus.intial,
        user: User.initial(),
        customError: CustomError());
  }

  @override
  bool get stringify => true;

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }

  @override
  List<Object> get props => [profileStatus, user, customError];
}
