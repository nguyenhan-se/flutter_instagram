import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User> get user;
  Future<auth.User> signUpWithEmailAndPassword({
    String username,
    String email,
    String password,
  });
  Future<auth.User> loginInWithEmailAndPassword({
    String email,
    String password,
  });
  Future<void> logout();
}
