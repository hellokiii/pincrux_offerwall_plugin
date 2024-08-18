import 'package:flutter_test/flutter_test.dart';
import 'package:pincrux_offerwall_plugin/pincrux_offerwall_plugin.dart';
import 'package:pincrux_offerwall_plugin/pincrux_offerwall_plugin_platform_interface.dart';
import 'package:pincrux_offerwall_plugin/pincrux_offerwall_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPincruxOfferwallPluginPlatform
    with MockPlatformInterfaceMixin
    implements PincruxOfferwallPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> init(String? pubkey, String? usrkey) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> setAdDetail(bool isEnable) {
    // TODO: implement setAdDetail
    throw UnimplementedError();
  }

  @override
  Future<void> setDarkMode(int mode) {
    // TODO: implement setDarkMode
    throw UnimplementedError();
  }

  @override
  Future<void> setDisableCPS(bool isDisable) {
    // TODO: implement setDisableCPS
    throw UnimplementedError();
  }

  @override
  Future<void> setEnableScrollTopButton(bool isEnable) {
    // TODO: implement setEnableScrollTopButton
    throw UnimplementedError();
  }

  @override
  Future<void> setEnableTab(bool isEnable) {
    // TODO: implement setEnableTab
    throw UnimplementedError();
  }

  @override
  Future<void> setOfferwallThemeColor(String? color) {
    // TODO: implement setOfferwallThemeColor
    throw UnimplementedError();
  }

  @override
  Future<void> setOfferwallTitle(String? title) {
    // TODO: implement setOfferwallTitle
    throw UnimplementedError();
  }

  @override
  Future<void> setOfferwallType(int type) {
    // TODO: implement setOfferwallType
    throw UnimplementedError();
  }

  @override
  Future<void> setOfferwallViewControllerType(int type) {
    // TODO: implement setOfferwallViewControllerType
    throw UnimplementedError();
  }

  @override
  Future<void> startPincruxOfferwall() {
    // TODO: implement startPincruxOfferwall
    throw UnimplementedError();
  }

  @override
  Future<void> startPincruxOfferwallAdDetail(String? appkey) {
    // TODO: implement startPincruxOfferwallAdDetail
    throw UnimplementedError();
  }

  @override
  Future<void> startPincruxOfferwallContact() {
    // TODO: implement startPincruxOfferwallContact
    throw UnimplementedError();
  }

  @override
  Future<void> startPincruxOfferwallViewType() {
    // TODO: implement startPincruxOfferwallViewType
    throw UnimplementedError();
  }
}

void main() {
  final PincruxOfferwallPluginPlatform initialPlatform = PincruxOfferwallPluginPlatform.instance;

  test('$MethodChannelPincruxOfferwallPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPincruxOfferwallPlugin>());
  });

  test('getPlatformVersion', () async {
    PincruxOfferwallPlugin pincruxOfferwallPlugin = PincruxOfferwallPlugin();
    MockPincruxOfferwallPluginPlatform fakePlatform = MockPincruxOfferwallPluginPlatform();
    PincruxOfferwallPluginPlatform.instance = fakePlatform;

    expect(await pincruxOfferwallPlugin.getPlatformVersion(), '42');
  });

}
