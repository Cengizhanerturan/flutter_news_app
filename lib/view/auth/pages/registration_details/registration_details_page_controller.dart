import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/view/auth/auth_page_controller.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class RegistrationDetailsPageController extends GetxController {
  final _authPageController = Get.find<AuthPageController>();
  final _userRepository = Get.find<UserRepositoryImpl>();

  final registrationDetailsFormKey = GlobalKey<FormState>();

  final nameTextEditingController = TextEditingController();

  String get _name => _authPageController.name.value;
  set name(String value) {
    _authPageController.name.value = value;
  }

  final surnameTextEditingController = TextEditingController();

  String get _surname => _authPageController.surname.value;
  set surname(String value) {
    _authPageController.surname.value = value;
  }

  bool get isButtonEnabled {
    if (_name.isNotEmpty &&
        _surname.isNotEmpty &&
        Validator.validateName(_name) == null &&
        Validator.validateSurname(_surname) == null) {
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
      if (registrationDetailsFormKey.currentState?.validate() ?? false) {
        FocusScope.of(context).unfocus();
        _change(AuthStateLoading());
        final user = await _userRepository.getUser();
        if (user == null) {
          throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
        }
        final userModel = UserModel(
          userId: user.uid,
          name: _name.trim(),
          surname: _surname.trim(),
          email: _authPageController.mail.value.trim(),
          createdTime: Timestamp.now(),
        );
        final isCreated = await _userRepository.createUserInformation(
          userModel,
        );
        if (isCreated) {
          await goToPage();
          _change(AuthStateSuccess());
        } else {
          throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
        }
      }
    } catch (e) {
      _change(AuthStateError(StringConstants.DEFAULT_ERROR_MESSAGE));
      await Get.dialog(
        CustomDialog(message: StringConstants.DEFAULT_ERROR_MESSAGE),
      );
    }
  }

  Future<void> backToPage() async {
    await _authPageController.backToPage();
  }

  Future<void> goToPage() async {
    await Get.offAndToNamed(Routes.LANDING);
  }
}
