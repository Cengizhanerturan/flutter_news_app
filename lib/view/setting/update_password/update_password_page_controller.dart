import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/state.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class UpdatePasswordPageController extends GetxController {
  final _userRepository = Get.find<UserRepositoryImpl>();

  final formKey = GlobalKey<FormState>();

  final currentPasswordTextEditingController = TextEditingController();
  final _currentPassword = ''.obs;
  String get currentPassword => _currentPassword.value;
  set currentPassword(String value) {
    _currentPassword.value = value;
  }

  final passwordTextEditingController = TextEditingController();
  final _password = ''.obs;
  String get password => _password.value;
  set password(String value) {
    _password.value = value;
  }

  final repasswordTextEditingController = TextEditingController();
  final _repassword = ''.obs;
  String get repassword => _repassword.value;
  set repassword(String value) {
    _repassword.value = value;
  }

  final _state = Rx<PageState>(Idle());
  PageState get state => _state.value;
  void _change(PageState state) {
    _state.value = state;
  }

  bool get isButtonEnabled {
    if (currentPassword.isEmpty ||
        Validator.validatePassword(currentPassword) != null) {
      return false;
    }
    if (password.isEmpty || Validator.validatePassword(password) != null) {
      return false;
    }
    if (repassword.isEmpty ||
        Validator.validateRePassword(password, repassword) != null) {
      return false;
    }
    return true;
  }

  void _clear() {
    currentPasswordTextEditingController.clear();
    _currentPassword.value = '';
    passwordTextEditingController.clear();
    _password.value = '';
    repasswordTextEditingController.clear();
    _repassword.value = '';
    _change(Idle());
  }

  Future<void> onTap(BuildContext context) async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        FocusScope.of(context).unfocus();
        _change(Loading());
        await _userRepository.changePassword(currentPassword, password);
        _change(Success());
        _clear();
        await Get.dialog(
          CustomDialog(
            message: StringConstants.UPDATE_PASSWORD_SUCCESS_MESSAGE,
          ),
        );
      }
    } catch (e) {
      final errorMessage = Helper.handleAuthErrorMessage(e);
      _change(Error(errorMessage));
      await Get.dialog(CustomDialog(message: errorMessage));
    }
  }
}
