

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

  UserEntity get currentUserData =>_profileRepo.currentUserData;
  void getWatchList()async{
    emit(const ProfileState.loading());
      try {
       var data = await _profileRepo.getData(path: "watchList");
        emit(ProfileState<List<MovieEntity>>.success(data));
      } on Exception catch (e) {
        emit(ProfileState.failure(e.toString()));
      }
  }
  void getHistory()async{
    emit(const ProfileState.loading());
    try {
      var data = await _profileRepo.getData(path: "history");
      emit(ProfileState<List<MovieEntity>>.success(data));
    } on Exception catch (e) {
      emit(ProfileState.failure(e.toString()));
    }
  }
}
