import 'package:injectable/injectable.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/features/auth/data/model/user_data.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

import '../../domain/repos/auth_repo.dart';
@Singleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo{
  final AuthService _authService;
  AuthRepoImpl(this._authService);
  @override
  Future<void> login(String email, String password) async{
    await _authService.login(email, password);

  }

  @override
  Future<void> loginWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  @override
  Future<void> register({required UserEntity user, required String password}) async{
    UserData userData = UserData(name: user.name, phoneNumber: user.phone, email: user.email, avatarCode: user.avatarCode);
    await _authService.register(user: userData, password: password);
  }

  @override
  Future<void> verifyEmail(String email) async {
    await _authService.resetPassword(email);
  }

  @override

  bool get isVerified =>  _authService.isVerified;




}