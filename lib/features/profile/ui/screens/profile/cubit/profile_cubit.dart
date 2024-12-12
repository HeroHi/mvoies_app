import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_state.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/repos/profile_repo.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(const ProfileState.initial());

  Future<UserEntity> get currentUserData async => await _profileRepo.currentUserData;
  Future<void> getWatchList() async {
    print("loading");
    emit(const ProfileState.loading());
    try {
      var data = await _profileRepo.getData(path: "watchList");
      emit(ProfileState<List<MovieEntity>>.success(data));
      print("success");
    } on Exception catch (e) {
      print("failure");
      emit(ProfileState.failure(e.toString()));
    }
  }

  Future<void> getHistory() async {
    print("loading history");
    emit(const ProfileState.historyLoading());
    try {
      var data = await _profileRepo.getData(path: "history");
      print("success history");
      emit(ProfileState<List<MovieEntity>>.historySuccess(data));
    } on Exception catch (e) {
      print("failure history");
      emit(ProfileState.historyFailure(e.toString()));
    }
  }

  void logout() async {
    try {
      await _profileRepo.logout();
    } on FirebaseAuthException catch (e) {
      emit(ProfileState.failure(e.message!));
    } catch (e) {
      emit(ProfileState.failure(e.toString()));
    }
  }
}
