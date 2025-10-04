import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/core/model/states/user_state.dart';
import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:get/get.dart';

abstract class UserRepository extends GetxService {
  Future<bool> isUserAvailable();

  Future<UserState> login(String email, String password);

  Future<void> register(String email, String password);

  Future<bool> createUserInformation(UserModel userModel);

  Future<bool> updateUserInformation(UserModel userModel);

  Future<bool> checkEmailVerification();

  Future<bool> sendEmailVerification();

  Future<User?> getUser();

  Future<bool> initUser();

  Future<bool> checkEmailExists(String email);

  Future<void> changePassword(String password, String newPassword);

  Future<void> changeEmail(String email, String password, String newEmail);

  Future<void> logout();
}
