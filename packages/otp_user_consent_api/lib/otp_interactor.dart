import 'dart:io';

import 'package:flutter/services.dart';

typedef StringCallback = void Function(String);

/// Methods
const getTelephoneHint = 'getTelephoneHint';
const startListenForCodeMethod = 'startListenForCode';
const stopListenForCodeMethod = 'stopListenForCode';

/// Arguments
const senderTelephoneNumber = 'senderTelephoneNumber';

/// Interact with native to get OTP code and telephone hint
class OTPInteractor {
  static const MethodChannel _channel =
      MethodChannel('otp_text_edit_controller');

  /// Show user telephone picker and get chosen number
  static Future<String> get hint {
    if (Platform.isAndroid) {
      return _channel.invokeMethod(getTelephoneHint);
    } else {
      return Future.value(null);
    }
  }

  /// Broadcast receiver stop listen for OTP code, use in dispose
  Future<dynamic> stopListenForCode() {
    return _channel.invokeMethod<dynamic>(stopListenForCodeMethod);
  }

  /// Broadcast receiver start listen for OTP code
  Future<String> startListenForCode([String senderPhone]) async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod<String>(
        startListenForCodeMethod,
        <String, String>{
          senderTelephoneNumber: senderPhone,
        },
      );
    } else {
      return null;
    }
  }
}
