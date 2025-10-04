import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/user_state.dart';
import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:flutter_news_app/core/service/remote/firestore_service.dart';
import 'package:flutter_news_app/core/service/remote/auth_service.dart';
import 'package:flutter_news_app/core/service/remote/user_service.dart';
import 'package:flutter_news_app/core/service/repository/user_repository.dart';
import 'package:get/get.dart';

class UserRepositoryImpl extends UserRepository {
  final _authService = Get.find<AuthService>();
  final _firestoreService = Get.find<FirestoreService>();
  final _userService = Get.find<UserService>();

  @override
  Future<bool> isUserAvailable() async {
    try {
      return await _authService.isUserAvailable();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserState> login(String email, String password) async {
    try {
      var userState = await _authService.loginWithEmailAndPassword(
        email,
        password,
      );
      if (_authService.currentUser == null) {
        throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
      }
      var userId = _authService.currentUser!.uid;
      var userModel = await _firestoreService.getUser(userId);
      if (userModel == null) {
        throw Exception(StringConstants.USER_NOT_FOUND_ERROR_MESSAGE);
      }
      _userService.user = userModel;
      return userState;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await _authService.registerWithEmailAndPassword(email, password);
      if (_authService.currentUser == null) {
        throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createUserInformation(UserModel userModel) async {
    try {
      var isCreated = await _firestoreService.createUser(userModel);
      if (isCreated) {
        _userService.user = userModel;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateUserInformation(UserModel userModel) async {
    try {
      var isUpdated = await _firestoreService.updateUser(userModel);
      if (isUpdated) {
        _userService.user = userModel;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkEmailVerification() async {
    try {
      return await _authService.checkEmailVerification();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> sendEmailVerification() async {
    try {
      return await _authService.sendEmailVerification();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      return await _authService.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> initUser() async {
    try {
      var currentUser = await _authService.getCurrentUser();
      if (currentUser == null) {
        return false;
      }
      var userId = currentUser.uid;
      var userModel = await _firestoreService.getUser(userId);
      if (userModel == null) {
        return false;
      }
      _userService.user = userModel;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    try {
      return await _firestoreService.checkEmailExists(email);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> changePassword(String password, String newPassword) async {
    try {
      if (_userService.user != null) {
        var email = _userService.user!.email;
        await _authService.changePasswordWithReauth(
          email,
          password,
          newPassword,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeEmail(
    String email,
    String password,
    String newEmail,
  ) async {
    try {
      await _authService.changeEmail(email, password, newEmail);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _authService.logout();
      _userService.user = null;
    } catch (e) {
      rethrow;
    }
  }
}
