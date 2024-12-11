import 'package:bloc/bloc.dart';
import 'package:movies_app/core/services/supabase/supabase_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());
  Future<void> login(String email,String password) async {
    emit(const LoginState.loading());
    try{
      await SupabaseHelper.login(email, password);
      emit(const LoginState.success());
    }
    on AuthException catch(error){
      emit(LoginState.failure(error.message));
    }
    catch(e){
      emit(LoginState.failure(e.toString()));
    }
  }
}
