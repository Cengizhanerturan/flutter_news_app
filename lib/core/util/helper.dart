import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_news_app/core/constants/string_constants.dart';

class Helper {
  static dynamic handleResponse(
    dio.Response<dynamic> response,
    Function(dynamic) decoder,
  ) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        if (response.data != null) {
          if (response.data.isEmpty) {
            throw StringConstants.EMPTY_RESPONSE;
          } else {
            return decoder(response.data);
          }
        } else {
          throw StringConstants.EMPTY_RESPONSE;
        }
      case HttpStatus.internalServerError:
        throw StringConstants.SERVER_ERROR;
      case HttpStatus.requestTimeout:
        throw StringConstants.TIMEOUT_ERROR;
      case HttpStatus.gatewayTimeout:
        throw StringConstants.TIMEOUT_ERROR;
      default:
        throw StringConstants.DEFAULT_ERROR_MESSAGE;
    }
  }

  static bool handleTokenExpiredControl(dynamic error) {
    final message = error.toString();
    if (message.contains('user-token-expired')) {
      return true;
    }
    return false;
  }

  static String handleAuthErrorMessage(dynamic error) {
    final message = error.toString();

    if (message.contains('invalid-email')) {
      return StringConstants.INVALID_EMAIL_ERROR_MESSAGE;
    } else if (message.contains('user-disabled')) {
      return StringConstants.USER_DISABLED_ERROR_MESSAGE;
    } else if (message.contains('user-not-found')) {
      return StringConstants.USER_MAIL_NOT_FOUND_ERROR_MESSAGE;
    } else if (message.contains('wrong-password')) {
      return StringConstants.WRONG_PASSWORD_ERROR_MESSAGE;
    } else if (message.contains('email-already-in-use')) {
      return StringConstants.EMAIL_ALREADY_IN_USE_ERROR_MESSAGE;
    } else if (message.contains('operation-not-allowed')) {
      return StringConstants.OPERATION_NOT_ALLOWED_ERROR_MESSAGE;
    } else if (message.contains('weak-password')) {
      return StringConstants.WEAK_PASSWORD_ERROR_MESSAGE;
    } else if (message.contains('too-many-requests')) {
      return StringConstants.TOO_MANY_REQUESTS_ERROR_MESSAGE;
    } else if (message.contains('network-request-failed')) {
      return StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE;
    } else if (message.contains('missing-email')) {
      return StringConstants.MISSING_EMAIL_ERROR_MESSAGE;
    } else if (message.contains('internal-error')) {
      return StringConstants.INTERNAL_ERROR_ERROR_MESSAGE;
    } else if (message.contains('invalid-credential')) {
      return StringConstants.INVALID_CREDENTIAL_ERROR_MESSAGE;
    } else if (message.contains('account-exists-with-different-credential')) {
      return StringConstants
          .ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL_ERROR_MESSAGE;
    } else if (message.contains('invalid-verification-code')) {
      return StringConstants.INVALID_VERIFICATION_CODE_ERROR_MESSAGE;
    } else if (message.contains('invalid-verification-id')) {
      return StringConstants.INVALID_VERIFICATION_ID_ERROR_MESSAGE;
    }

    return StringConstants.DEFAULT_ERROR_MESSAGE;
  }
}
