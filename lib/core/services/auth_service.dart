

import '../../features/auth/data/model/user_data.dart';

abstract class AuthService{
  Future<void> login(String email, String password);
  Future<void> register(
      {required UserData user,required String password});
  Future<void> update(
      {required UserData user});
  Future<void> delete();
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<void> signInWithGoogle();
  Future<void> updatePassword(String password);
  bool get isVerified;
  dynamic get currentUser;
}