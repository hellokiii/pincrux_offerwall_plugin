
import 'pincrux_offerwall_plugin_platform_interface.dart';

class PincruxOfferwallPlugin {
  Future<String?> getPlatformVersion() {
    return PincruxOfferwallPluginPlatform.instance.getPlatformVersion();
  }
}
