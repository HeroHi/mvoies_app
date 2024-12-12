import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class AuthRepo{
   Future<void> login(String email, String password);
   Future<void> register(
      {required UserEntity user,required String password});
   Future<void> verifyEmail(String email);
   Future<void> loginWithGoogle();
   bool get isVerified;
}