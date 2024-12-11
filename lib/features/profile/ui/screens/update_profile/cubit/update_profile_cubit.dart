import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/profile/domain/repos/profile_repo.dart';
import 'package:movies_app/features/profile/ui/screens/update_profile/cubit/update_profile_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/entities/user_entity.dart';
@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepo _profileRepo;
  UpdateProfileCubit(this._profileRepo) : super(const UpdateProfileState.initial());

  UserEntity get currentUserData =>_profileRepo.currentUserData;
  void updateAcc(
      {required String name,
      required String phoneNumber,
      required String avatarCode}) {
    emit(const UpdateProfileState.loading());
    try {
      _profileRepo.update(
          name: name, avatarCode: avatarCode, phoneNumber: phoneNumber);
    } on AuthException catch (e) {
      emit(UpdateProfileState.failure(e.message));
    } catch (e) {
      emit(UpdateProfileState.failure(e.toString()));
    }
  }
  void deleteAcc(){
    emit(const UpdateProfileState.loading());
    try {
      _profileRepo.delete();
    } on AuthException catch (e) {
      emit(UpdateProfileState.failure(e.message));
    } catch (e) {
      emit(UpdateProfileState.failure(e.toString()));
    }
  }
}
