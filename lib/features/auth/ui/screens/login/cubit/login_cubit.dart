import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/auth/domain/repos/auth_repo.dart';

import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;
  LoginCubit(this._authRepo) : super(const LoginState.initial());
  Future<void> login(String email,String password) async {
    emit(const LoginState.loading());
    try{
      await _authRepo.login(email, password);
      emit(const LoginState.success());
    }
    on FirebaseAuthException catch(error){
      emit(LoginState.failure(error.message!));
    }
    catch(e){
      emit(LoginState.failure(e.toString()));
    }
  }
  Future<void> resetPassword(String email) async {
    emit(const LoginState.loading());
    try{
      await _authRepo.verifyEmail(email);
      emit(const LoginState.success());
    }
    on FirebaseAuthException catch(error){
      emit(LoginState.failure(error.message!));
    }
    catch(e){
      emit(LoginState.failure(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(const LoginState.loading());
    try{
      await _authRepo.loginWithGoogle();
      emit(const LoginState.success());
    }
    on FirebaseAuthException catch(error){
      emit(LoginState.failure(error.message!));
    }
    catch(e){
      emit(LoginState.failure(e.toString()));
    }
  }
  bool get isVerified => _authRepo.isVerified;
}
