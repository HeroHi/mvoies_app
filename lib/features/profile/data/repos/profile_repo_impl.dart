import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/services/database_service.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
import 'package:movies_app/features/profile/domain/repos/profile_repo.dart';

import '../../../auth/data/model/user_data.dart';
import '../../../main_layout/domain/entities/movie_entity.dart';
@Singleton(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final AuthService _authService;
  final DatabaseService _databaseService;
  ProfileRepoImpl(this._databaseService,this._authService);
  @override
  void update(
      {required String avatarCode,
      required String name,
      required String phoneNumber})  {
    var currentUser = _authService.currentUser as User;
    UserData user = UserData(name: name, phoneNumber: phoneNumber, email: currentUser.email!, avatarCode: avatarCode);
    _authService.update(user: user);
  }

  @override
  Future<void> delete() async {
    await _authService.delete();
  }

  @override
  Future<List<MovieEntity>> getData(
      {required String path}) async{
    var response = await _databaseService.getData(path: path) as List<Map<String,dynamic>>;
    List<MovieEntity> movies = response.map((json) => MovieEntity(rating: json['rating'], id: json['id'],posterPath: json['posterPath'])).toList();
    return movies;
  }


  @override
  Future<void> logout() async{
    await _authService.logout();
  }


  @override

  Future<UserEntity> get currentUserData async {
    var currentUser = _authService.currentUser as User;
    String phone = await _databaseService.getPhone();
    return UserEntity(avatarCode: currentUser.photoURL!, name: currentUser.displayName??"No", email: currentUser.email!, phone: phone);
  }
}
