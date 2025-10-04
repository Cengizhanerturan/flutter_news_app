import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/state.dart';
import 'package:flutter_news_app/core/service/remote/user_service.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/util/get_extension.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class UpdateMailPageController extends GetxController {
  final _userRepository = Get.find<UserRepositoryImpl>();
  final _userService = Get.find<UserService>();

  final formKey = GlobalKey<FormState>();

  final currentEmailTextEditingController = TextEditingController();

  final passwordTextEditingController = TextEditingController();
  final _password = ''.obs;
  String get password => _password.value;
  set password(String value) {
    _password.value = value;
  }

  final emailTextEditingController = TextEditingController();
  final _email = ''.obs;
  String get email => _email.value;
  set email(String value) {
    _email.value = value;
  }

  final _state = Rx<PageState>(Idle());
  PageState get state => _state.value;
  void _change(PageState state) {
    _state.value = state;
  }

  @override
  void onInit() {
    super.onInit();
    if (_userService.user != null) {
      currentEmailTextEditingController.text = _userService.user!.email;
    }
  }

  bool get isButtonEnabled {
    if (password.isEmpty || Validator.validatePassword(password) != null) {
      return false;
    }
    if (email.isEmpty || Validator.validateEmail(email) != null) {
      return false;
    }
    return true;
  }

  Future<void> onTap(BuildContext context) async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        FocusScope.of(context).unfocus();
        _change(Loading());

        var isEmailExists = await _userRepository.checkEmailExists(email);
        if (isEmailExists) {
          _change(Success());
          await Get.dialog(
            CustomDialog(
              message: StringConstants.MAIL_ALREADY_EXISTS_ERROR_MESSAGE,
            ),
          );
        } else {
          await _userRepository.changeEmail(
            currentEmailTextEditingController.text.trim(),
            password.trim(),
            email.trim(),
          );
          var userModel = _userService.user!.copyWith(email: email);
          var isUpdated = await _userRepository.updateUserInformation(
            userModel,
          );
          if (isUpdated) {
            _change(Success());
            await Get.dialog(
              CustomDialog(
                message: StringConstants.UPDATE_MAIL_SUCCESS_MESSAGE,
                primaryButtonOnTap:
                    () async =>
                        await Get.toVerifyPageFromUpdateMailPage(email.trim()),
              ),
            ).then(
              (_) async =>
                  await Get.toVerifyPageFromUpdateMailPage(email.trim()),
            );
          } else {
            throw Exception(StringConstants.UPDATE_MAIL_ERROR_MESSAGE);
          }
        }
      }
    } catch (e) {
      final errorMessage = Helper.handleAuthErrorMessage(e);
      _change(Error(errorMessage));
      await Get.dialog(CustomDialog(message: errorMessage));
    }
  }
}
