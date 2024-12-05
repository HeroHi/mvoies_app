import 'package:movies_app/features/auth/ui/model/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
abstract class SupabaseHelper {
  static const String url = "https://zqkqodednvzxnqqjmvay.supabase.co";
  static const String anonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpxa3FvZGVkbnZ6eG5xcWptdmF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM0MjU4MzYsImV4cCI6MjA0OTAwMTgzNn0.Q8I8aJ1rJDwrrdCkrOZoNJp_3pBLh03KXfdd6R1X9wM";
  static final _supabase = Supabase.instance.client;
  static Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(password: password, email: email);
  }
  static Future<void> register(
      {required UserData user,required String password}) async {
    await _supabase.auth.signUp(password: password,email: user.email,data:user.toJson() );
  }
}
