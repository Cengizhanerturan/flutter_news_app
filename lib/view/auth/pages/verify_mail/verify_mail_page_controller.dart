import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/view/auth/auth_page_controller.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class VerifyMailPageController extends GetxController {
  final bool isFromAuthPage;
  final bool isFromUpdateMailPage;
  final String? newEmail;
  VerifyMailPageController({
    this.isFromAuthPage = true,
    this.isFromUpdateMailPage = false,
    this.newEmail,
  });

  AuthPageController? _authPageController;
  final _userRepository = Get.find<UserRepositoryImpl>();

  Timer? _timer;

  final _state = Rx<AuthState>(AuthStateLoading());
  AuthState get state => _state.value;
  void _change(AuthState state) {
    _state.value = state;
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    if (isFromAuthPage) {
      _authPageController = Get.find<AuthPageController>();
    }

    _startEmailCheckTimer();
    await _userRepository.sendEmailVerification();
  }

  void _startEmailCheckTimer() {
    if (_timer != null && _timer!.isActive) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      try {
        if (isFromUpdateMailPage) {
          var currentUser = await _userRepository.getUser();
          if (currentUser?.email == newEmail) {
            final isVerified = await _userRepository.checkEmailVerification();
            if (isVerified) {
              _timer?.cancel();
              _change(AuthStateSuccess());
            }
          }
        } else {
          final isVerified = await _userRepository.checkEmailVerification();
          if (isVerified) {
            _timer?.cancel();
            _change(AuthStateSuccess());
          }
        }
      } catch (e) {
        _timer?.cancel();
        if (Helper.handleTokenExpiredControl(e)) {
          Get.dialog(
            CustomDialog(
              message:
                  'The user\'s credential is no longer valid. The user must sign in again.',
              primaryButtonOnTap:
                  () async => await Get.offAllNamed(Routes.AUTH),
            ),
          ).then((_) async => await Get.offAllNamed(Routes.AUTH));
        } else {
          var errorMessage = Helper.handleAuthErrorMessage(e);
          _change(AuthStateError(errorMessage));
          Get.dialog(CustomDialog(message: errorMessage));
        }
      }
    });
  }

  Future<void> onTap(BuildContext context) async {
    if (state is AuthStateSuccess) {
      await goToPage();
    }
  }

  Future<void> backToPage() async {
    await _authPageController?.backToPage();
  }

  Future<void> goToPage() async {
    await _authPageController?.goToPage();
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
