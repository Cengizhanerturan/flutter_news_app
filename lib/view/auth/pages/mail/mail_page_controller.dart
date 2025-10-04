import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/view/auth/auth_page_controller.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class MailPageController extends GetxController {
  final _authPageController = Get.find<AuthPageController>();
  final _userRepository = Get.find<UserRepositoryImpl>();

  final mailFormKey = GlobalKey<FormState>();
  final mailTextEditingController = TextEditingController();

  String get _mail => _authPageController.mail.value;
  set mail(String value) {
    _authPageController.mail.value = value;
  }

  bool get isButtonEnabled {
    if (_mail.isNotEmpty && Validator.validateEmail(_mail) == null) {
      return true;
    }
    return false;
  }

  final _state = Rx<AuthState>(AuthStateInitial());
  AuthState get state => _state.value;
  void _change(AuthState state) {
    _state.value = state;
  }

  Future<void> onTap(BuildContext context) async {
    try {
      if (mailFormKey.currentState?.validate() ?? false) {
        _change(AuthStateLoading());
        FocusScope.of(context).unfocus();
        var isEmailExistys = await _userRepository.checkEmailExists(_mail);
        if (isEmailExistys) {
          _authPageController.authType.value = AUTH_TYPE.LOGIN;
        } else {
          _authPageController.authType.value = AUTH_TYPE.REGISTER;
        }
        await goToPage();
        _change(AuthStateSuccess());
      }
    } catch (e) {
      final errorMessage = Helper.handleAuthErrorMessage(e);
      _change(AuthStateError(errorMessage));
      Get.dialog(CustomDialog(message: errorMessage));
    }
  }

  Future<void> goToPage() async {
    await _authPageController.goToPage();
  }
}
