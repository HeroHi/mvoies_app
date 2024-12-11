import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepo {
  void update(
      {required String avatarCode,
      required String name,
      required String phoneNumber});

  Future<void> delete();

  Future<List<MovieEntity>> getData({
    required String path,
  });


  Future<void> logout();
  UserEntity get currentUserData;
}


