import 'package:injectable/injectable.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/auth/data/model/user_data.dart';

@Singleton(as: AuthService)
class SupabaseAuthService extends AuthService{
   final _supabase = Supabase.instance.client;
   @override
  Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(password: password, email: email);
  }
   @override
  Future<void> register(
      {required UserData user,required String password}) async {
    await _supabase.auth.signUp(password: password,email: user.email,data:user.toJson() );
  }
   @override
  Future<void> update(
      {required UserData user}) async {
    _supabase.auth.updateUser(UserAttributes(data: user.toJson()));
  }
   @override
  Future<void> delete() async {
    await _supabase.auth.admin.deleteUser(_supabase.auth.currentUser!.id);
  }

  @override
  User get currentUser => _supabase.auth.currentUser!;

  @override
  Future<void> logout() async{
    await _supabase.auth.signOut();
  }
}