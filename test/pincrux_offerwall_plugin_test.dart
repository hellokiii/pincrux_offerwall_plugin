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
