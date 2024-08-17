import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pincrux_offerwall_plugin_platform_interface.dart';

/// An implementation of [PincruxOfferwallPluginPlatform] that uses method channels.
class MethodChannelPincruxOfferwallPlugin extends PincruxOfferwallPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pincrux_offerwall_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> init(String? pubkey, String? usrkey) async {
    await methodChannel
        .invokeListMethod("init", {'pubkey': pubkey, 'usrkey': usrkey});
  }

  @override
  Future<void> setOfferwallViewControllerType(int type) async {
    if (Platform.isIOS) {
      await methodChannel
          .invokeListMethod("setOfferwallViewControllerType", {'type': type});
    }
  }

  @override
  Future<void> startPincruxOfferwall() async {
    await methodChannel.invokeMethod("startOfferwall");
  }

  @override
  Future<void> startPincruxOfferwallViewType() async {
    await methodChannel.invokeMethod("startPincruxOfferwallViewType");
  }

  @override
  Future<void> startPincruxOfferwallAdDetail(String? appkey) async {
    await methodChannel
        .invokeMethod("startPincruxOfferwallAdDetail", {'appkey': appkey});
  }

  @override
  Future<void> startPincruxOfferwallContact() async {
    await methodChannel.invokeMethod("startPincruxOfferwallContact");
  }

  // Offerwall View Options
  @override
  Future<void> setOfferwallType(int type) async {
    await methodChannel.invokeMethod("setOfferwallType", {'type': type});
    // await methodChannel.invokeMethod("setOfferwallType", type);
  }

  @override
  Future<void> setEnableTab(bool isEnable) async {
    await methodChannel.invokeMethod("setEnableTab", {'isEnable': isEnable});
  }

  @override
  Future<void> setOfferwallTitle(String? title) async {
    await methodChannel.invokeMethod("setOfferwallTitle", {'title': title});
  }

  @override
  Future<void> setOfferwallThemeColor(String? color) async {
    await methodChannel.invokeMethod("setOfferwallThemeColor", {'color': color});
  }

  @override
  Future<void> setEnableScrollTopButton(bool isEnable) async {
    await methodChannel
        .invokeMethod("setEnableScrollTopButton", {'isEnable': isEnable});
  }

  @override
  Future<void> setAdDetail(bool isEnable) async {
    await methodChannel.invokeMethod("setAdDetail", {'isEnable': isEnable});
  }

  @override
  Future<void> setDisableCPS(bool isDisable) async {
    await methodChannel.invokeMethod("setDisableCPS", {'isDisable': isDisable});
  }

  @override
  Future<void> setDarkMode(int mode) async {
    await methodChannel.invokeMethod("setDarkMode", {'mode': mode});
  }

}
