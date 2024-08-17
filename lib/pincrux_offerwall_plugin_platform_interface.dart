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
}
