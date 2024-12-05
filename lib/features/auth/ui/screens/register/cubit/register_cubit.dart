import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/networking/supabase_helper.dart';
import 'package:movies_app/features/auth/ui/screens/register/cubit/register_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../model/user_data.dart';



class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState.initial());
  Future<void> register( UserData user, String password) async {
    emit(const RegisterState.loading());
    try {

      await SupabaseHelper.register(password:password, user: user,);
      emit(const RegisterState.success());

    }
    on AuthException  catch(error){
      emit( RegisterState.failure((error).message));
    }
    catch(e){
      emit( RegisterState.failure(e.toString()));
    }

  }
}
