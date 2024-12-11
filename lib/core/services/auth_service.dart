

import '../../features/auth/data/model/user_data.dart';

abstract class AuthService{
  Future<void> login(String email, String password);
  Future<void> register(
      {required UserData user,required String password});
  Future<void> update(
      {required UserData user});
  Future<void> delete();
  Future<void> logout();
  dynamic get currentUser;
}