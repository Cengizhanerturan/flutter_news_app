import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/state.dart';
import 'package:flutter_news_app/core/service/remote/user_service.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class UpdateUserInformationPageController extends GetxController {
  final _userService = Get.find<UserService>();
  final _userRepository = Get.find<UserRepositoryImpl>();

  final formKey = GlobalKey<FormState>();

  final nameTextEditingController = TextEditingController();
  final _name = ''.obs;
  String get name => _name.value;
  set name(String value) {
    _name.value = value;
  }

  final surnameTextEditingController = TextEditingController();
  final _surname = ''.obs;
  String get surname => _surname.value;
  set surname(String value) {
    _surname.value = value;
  }

  final _state = Rx<PageState>(Idle());
  PageState get state => _state.value;
  void _change(PageState state) {
    _state.value = state;
  }

  @override
  void onInit() {
    super.onInit();
    setDefaultValues();
  }

  void setDefaultValues() {
    _change(Idle());
    if (_userService.user != null) {
      var user = _userService.user;
      name = user!.name;
      surname = user.surname;
      nameTextEditingController.text = name;
      surnameTextEditingController.text = surname;
    }
  }

  bool get isButtonEnabled {
    if (name.isNotEmpty &&
        surname.isNotEmpty &&
        Validator.validateName(name) == null &&
        Validator.validateSurname(surname) == null) {
      return true;
    }
    return false;
  }

  Future<void> onTap(BuildContext context) async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        FocusScope.of(context).unfocus();
        _change(Loading());
        var userModel = _userService.user!.copyWith(
          name: name,
          surname: surname,
        );
        var isUpdated = await _userRepository.updateUserInformation(userModel);
        if (isUpdated) {
          _change(Success());
          await Get.dialog(
            CustomDialog(
              message: StringConstants.UPDATE_USER_INFORMATION_SUCCESS_MESSAGE,
            ),
          );
        } else {
          throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
        }
      }
    } catch (e) {
      _change(Error(StringConstants.DEFAULT_ERROR_MESSAGE));
      await Get.dialog(
        CustomDialog(message: StringConstants.DEFAULT_ERROR_MESSAGE),
      );
    }
  }
}
