import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/model/states/user_state.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/view/auth/auth_page_controller.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class PasswordPageController extends GetxController {
  final _authPageController = Get.find<AuthPageController>();
  final _userRepository = Get.find<UserRepositoryImpl>();

  final passwordFormKey = GlobalKey<FormState>();
  final passwordTextEditingController = TextEditingController();
  final rePasswordTextEditingController = TextEditingController();

  get authType => _authPageController.authType.value;

  String get password => _authPageController.password.value;
  set onChangedPassword(String value) {
    _authPageController.password.value = value;
  }

  String get repassword => _authPageController.repassword.value;
  set onChangedRepassword(String value) {
    _authPageController.repassword.value = value;
  }

  bool get isButtonEnabled {
    if (password.isEmpty || Validator.validatePassword(password) != null) {
      return false;
    }
    if (authType == AUTH_TYPE.REGISTER) {
      if (repassword.isEmpty ||
          Validator.validateRePassword(password, repassword) != null) {
        return false;
      }
    }
    return true;
  }

  final _state = Rx<AuthState>(AuthStateInitial());
  AuthState get state => _state.value;
  void _change(AuthState state) {
    _state.value = state;
  }

  Future<void> onTap(BuildContext context) async {
    try {
      if (passwordFormKey.currentState?.validate() ?? false) {
        _change(AuthStateLoading());
        FocusScope.of(context).unfocus();

        if (authType == AUTH_TYPE.REGISTER) {
          await _register();
        } else {
          await _login(context);
        }

        _change(AuthStateSuccess());
      }
    } catch (e) {
      final errorMessage = Helper.handleAuthErrorMessage(e);
      _change(AuthStateError(errorMessage));
      await Get.dialog(CustomDialog(message: errorMessage));
    }
  }

  Future<void> _register() async {
    await _userRepository.register(
      _authPageController.mail.value.trim(),
      _authPageController.password.value.trim(),
    );
    await goToPage();
  }

  Future<void> _login(BuildContext context) async {
    final userState = await _userRepository.login(
      _authPageController.mail.value.trim(),
      _authPageController.password.value.trim(),
    );
    if (userState is UserStateVerified) {
      await Get.offAndToNamed(Routes.LANDING);
    } else {
      await Get.offAndToNamed(Routes.VERIFY_MAIL);
    }
  }

  Future<void> backToPage() async {
    await _authPageController.backToPage();
  }

  Future<void> goToPage() async {
    await _authPageController.goToPage();
  }
}
