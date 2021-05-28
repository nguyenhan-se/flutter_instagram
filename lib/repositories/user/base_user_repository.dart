import 'package:flutter_instagram/models/user_model.dart';

abstract class BaseUserRepository {
  Future<User> getUserById({String id});
  Future<void> updateUser({User user});
}
