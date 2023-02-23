import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/constants/exceptions.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  Stream<User?> get authStateChange => auth.authStateChanges();

  User? currentUser() {
    return auth.currentUser;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw BadRequestException(
            message: 'The password provided is too weak.',
            attribute: 'password');
      } else if (e.code == 'email-already-in-use') {
        throw BadRequestException(
            message: 'THE ACCOUNT ALREADY EXISTS FOR THAT EMAIL',
            attribute: 'email');
      }
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw BadRequestException(
            message: 'EMAIL OR PASSWORD IS WRONG', attribute: 'password');
      }
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential cred = await auth.signInWithCredential(credential);
      if (cred.additionalUserInfo?.isNewUser == true) {
        await auth.signInWithCredential(credential);
        return false;
      }
      await auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  GoogleSignInAccount googleUser() => GoogleSignIn().currentUser!;

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }
}
