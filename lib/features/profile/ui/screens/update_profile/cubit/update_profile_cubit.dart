import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/profile/domain/repos/profile_repo.dart';
import 'package:movies_app/features/profile/ui/screens/update_profile/cubit/update_profile_state.dart';

import '../../../../domain/entities/user_entity.dart';
@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepo _profileRepo;
  UpdateProfileCubit(this._profileRepo) : super(const UpdateProfileState.initial());

  Future<UserEntity> get currentUserData async => await _profileRepo.currentUserData;
  void updateAcc(
      {required String name,
      required String phoneNumber,
      required String avatarCode}) {
    emit(const UpdateProfileState.loading());
    try {
      _profileRepo.update(
          name: name, avatarCode: avatarCode, phoneNumber: phoneNumber);
    } on FirebaseAuthException catch (e) {
      emit(UpdateProfileState.failure(e.message!));
    } catch (e) {
      emit(UpdateProfileState.failure(e.toString()));
    }
  }
  void deleteAcc(){
    emit(const UpdateProfileState.loading());
    try {
      _profileRepo.delete();
    } on FirebaseAuthException catch (e) {
      emit(UpdateProfileState.failure(e.message!));
    } catch (e) {
      emit(UpdateProfileState.failure(e.toString()));
    }
  }
  void updatePassword(String password) async {
    emit(const UpdateProfileState.loading());
    try {
      await _profileRepo.updatePassword(password);
      emit(const UpdateProfileState.success());
    } on FirebaseAuthException catch (e) {
      emit(UpdateProfileState.failure(e.message!));
    } catch (e) {
      emit(UpdateProfileState.failure(e.toString()));
    }
  }
}
