import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/services/database_service.dart';
import '../../../features/auth/data/model/user_data.dart';
import 'package:movies_app/core/services/auth_service.dart';

@Singleton(as: AuthService)
class FirebaseAuthService extends AuthService {
  final DatabaseService _databaseService;
  FirebaseAuthService(this._databaseService);
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;
  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (!_firebaseAuth.currentUser!.emailVerified) {
      logout();
      throw "Email not verified";
    }
  }

  @override
  Future<void> register(
      {required UserData user, required String password}) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );
    await currentUser.updateProfile(
        displayName: user.name, photoURL: user.avatarCode);
    await _databaseService.updatePhone(user.phoneNumber);
    await sendEmailVerification();
    logout();
  }

  Future<void> sendEmailVerification() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    }
  }

  @override
  Future<void> update({required UserData user}) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.updateProfile(
          displayName: user.name, photoURL: user.avatarCode);
      await _databaseService.updatePhone(user.phoneNumber);
    }
  }

  @override
  Future<void> delete() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.delete();
    }
  }

  @override
  User get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    return user;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    String? displayName = googleUser?.displayName;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    currentUser.updateDisplayName(displayName);
  }

  @override
  bool get isVerified => _firebaseAuth.currentUser!.emailVerified;

  @override
  Future<void> updatePassword(String password) async{
    await currentUser.updatePassword(password);
  }
}
