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
}
