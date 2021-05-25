part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final auth.User user;
  final AuthStatus status;

  const AuthState({
    this.user,
    this.status = AuthStatus.unknown,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [user, status];
}
