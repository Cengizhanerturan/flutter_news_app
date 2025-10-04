import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/user_state.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  late final FirebaseAuth _auth;

  User? currentUser;

  @override
  void onInit() {
    super.onInit();
    _auth = FirebaseAuth.instance;
  }

  Future<User?> getCurrentUser() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.reload();
      }
      final user = _auth.currentUser;
      if (user != null) {
        currentUser ??= user;
        return user;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserAvailable() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<UserState> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
      }
      currentUser = userCredential.user!;
      var isVerified = await checkEmailVerification();
      if (isVerified) {
        return UserStateVerified();
      } else {
        await sendEmailVerification();
        return UserStateUnverified();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
      }
      currentUser = userCredential.user!;
      await sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      if (_auth.currentUser == null) {
        return false;
      }
      await _auth.currentUser!.reload();
      currentUser = _auth.currentUser!;
      return currentUser!.emailVerified;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendEmailVerification() async {
    try {
      if (currentUser == null) {
        return false;
      }
      await currentUser!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> checkAndSendEmailVerification() async {
    try {
      var isUserVerified = await checkEmailVerification();
      if (!isUserVerified) {
        await sendEmailVerification();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeEmail(
    String email,
    String password,
    String newEmail,
  ) async {
    try {
      await _reauthenticateUser(email, password);
      await currentUser?.verifyBeforeUpdateEmail(newEmail);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePasswordWithReauth(
    String email,
    String password,
    String newPassword,
  ) async {
    try {
      await _reauthenticateUser(email, password);
      await _changePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _changePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _reauthenticateUser(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser?.reauthenticateWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      currentUser = null;
    } catch (e) {
      rethrow;
    }
  }
}
