part of 'edit_profile_cubit.dart';

enum EditProfileStatus { initial, submitting, success, error }

class EditProfileState extends Equatable {
  final File profileImage;
  final String username;
  final String name;
  final String bio;
  final EditProfileStatus status;
  final Failure failure;

  EditProfileState({
    @required this.profileImage,
    @required this.username,
    @required this.name,
    @required this.bio,
    @required this.status,
    @required this.failure,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      profileImage: null,
      username: '',
      name: '',
      bio: '',
      status: EditProfileStatus.initial,
      failure: Failure(),
    );
  }

  EditProfileState copyWith({
    File profileImage,
    String username,
    String name,
    String bio,
    EditProfileStatus status,
    Failure failure,
  }) {
    return EditProfileState(
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props =>
      [profileImage, username, name, bio, status, failure];
}
