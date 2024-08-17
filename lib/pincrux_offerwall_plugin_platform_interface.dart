import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pincrux_offerwall_plugin_method_channel.dart';

abstract class PincruxOfferwallPluginPlatform extends PlatformInterface {
  /// Constructs a PincruxOfferwallPluginPlatform.
  PincruxOfferwallPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PincruxOfferwallPluginPlatform _instance = MethodChannelPincruxOfferwallPlugin();

  /// The default instance of [PincruxOfferwallPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPincruxOfferwallPlugin].
  static PincruxOfferwallPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PincruxOfferwallPluginPlatform] when
  /// they register themselves.
  static set instance(PincruxOfferwallPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> init(String? pubkey, String? usrkey) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> setOfferwallViewControllerType(int type) {
    throw UnimplementedError('setOfferwallViewControllerType() has not been implemented.');
  }

  Future<void> startPincruxOfferwall() {
    throw UnimplementedError('startPincruxOfferwall() has not been implemented.');
  }

  Future<void> startPincruxOfferwallViewType() {
    throw UnimplementedError('startPincruxOfferwallViewType() has not been implemented.');
  }

  Future<void> startPincruxOfferwallAdDetail(String? appkey) {
    throw UnimplementedError('startPincruxOfferwallAdDetail() has not been implemented.');
  }

  Future<void> startPincruxOfferwallContact() {
    throw UnimplementedError('startPincruxOfferwallContact() has not been implemented.');
  }

  // Offerwall View Options
  Future<void> setOfferwallType(int type) {
    throw UnimplementedError('setOfferwallType() has not been implemented.');
    // await _channel.invokeMethod("setOfferwallType", type);
  }

  Future<void> setEnableTab(bool isEnable) {
    throw UnimplementedError('setEnableTab() has not been implemented.');
  }

  Future<void> setOfferwallTitle(String? title) {
    throw UnimplementedError('setOfferwallTitle() has not been implemented.');
  }

  Future<void> setOfferwallThemeColor(String? color) {
    throw UnimplementedError('setOfferwallThemeColor() has not been implemented.');
  }

  Future<void> setEnableScrollTopButton(bool isEnable) {
    throw UnimplementedError('setEnableScrollTopButton() has not been implemented.');
  }

  Future<void> setAdDetail(bool isEnable) {
    throw UnimplementedError('setAdDetail() has not been implemented.');
  }

  Future<void> setDisableCPS(bool isDisable) {
    throw UnimplementedError('setDisableCPS() has not been implemented.');
  }

  Future<void> setDarkMode(int mode) {
    throw UnimplementedError('setDarkMode() has not been implemented.');
  }
}
