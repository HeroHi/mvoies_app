import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/auth/domain/repos/auth_repo.dart';
import 'package:movies_app/features/auth/ui/screens/register/cubit/register_state.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;
  RegisterCubit(this._authRepo) : super(const RegisterState.initial());
  Future<void> register( UserEntity user, String password) async {
    emit(const RegisterState.loading());
    try {

      await _authRepo.register(user: user, password: password);
      emit(const RegisterState.success());

    }
    on FirebaseAuthException  catch(error){
      emit( RegisterState.failure(error.message!));
    }
    catch(e){
      emit( RegisterState.failure(e.toString()));
    }

  }
}
