
import 'pincrux_offerwall_plugin_platform_interface.dart';

class PincruxOfferwallPlugin {
  Future<String?> getPlatformVersion() {
    return PincruxOfferwallPluginPlatform.instance.getPlatformVersion();
  }

  static void init(String? pubkey, String? usrkey) async {
    print('flutter init done');
    return PincruxOfferwallPluginPlatform.instance.init(pubkey, usrkey);
  }

  static void setOfferwallViewControllerType(int type) async {
    return PincruxOfferwallPluginPlatform.instance.setOfferwallViewControllerType(type);
  }

  static void startPincruxOfferwall() async {
    return PincruxOfferwallPluginPlatform.instance.startPincruxOfferwall();
  }

  static void startPincruxOfferwallViewType() async {
    return PincruxOfferwallPluginPlatform.instance.startPincruxOfferwallViewType();
  }

  static void startPincruxOfferwallAdDetail(String? appkey) async {
    return PincruxOfferwallPluginPlatform.instance.startPincruxOfferwallAdDetail(appkey);
  }

  static void startPincruxOfferwallContact() async {
    return PincruxOfferwallPluginPlatform.instance.startPincruxOfferwallContact();
  }

  // Offerwall View Options
  static void setOfferwallType(int type) async {
    return PincruxOfferwallPluginPlatform.instance.setOfferwallType(type);
    // await _channel.invokeMethod("setOfferwallType", type);
  }

  static void setEnableTab(bool isEnable) async {
    return PincruxOfferwallPluginPlatform.instance.setEnableTab(isEnable);
  }

  static void setOfferwallTitle(String? title) async {
    return PincruxOfferwallPluginPlatform.instance.setOfferwallTitle(title);
  }

  static void setOfferwallThemeColor(String? color) async {
    return PincruxOfferwallPluginPlatform.instance.setOfferwallThemeColor(color);
  }

  static void setEnableScrollTopButton(bool isEnable) async {
    return PincruxOfferwallPluginPlatform.instance.setEnableScrollTopButton(isEnable);
  }

  static void setAdDetail(bool isEnable) async {
    return PincruxOfferwallPluginPlatform.instance.setAdDetail(isEnable);
  }

  static void setDisableCPS(bool isDisable) async {
    return PincruxOfferwallPluginPlatform.instance.setDisableCPS(isDisable);
  }

  static void setDarkMode(int mode) async {
    return PincruxOfferwallPluginPlatform.instance.setDarkMode(mode);
  }


}
