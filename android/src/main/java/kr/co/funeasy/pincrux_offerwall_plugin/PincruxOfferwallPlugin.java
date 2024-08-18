package kr.co.funeasy.pincrux_offerwall_plugin;

import androidx.annotation.NonNull;
import com.pincrux.offerwall.PincruxOfferwall;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

/** PincruxOfferwallPlugin */
public class PincruxOfferwallPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;

  private PincruxOfferwall offerwall;



  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "pincrux_offerwall_plugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    offerwall = PincruxOfferwall.getInstance();

    switch (call.method) {
      case "getPlatformVersion": {
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      }

      case "init": {
        Log.d("initinititi", "hihi");
        String pubkey = call.argument("pubkey");
        String usrkey = call.argument("usrkey");
        offerwall.init(activity, pubkey, usrkey);
        break;
      }

      case "startOfferwall": {
        offerwall.startPincruxOfferwallActivity(activity);
        break;
      }

      case "startPincruxOfferwallViewType": {
        Intent intent = new Intent(activity, ViewTypeActivity.class);
        activity.startActivity(intent);
        break;
      }

      case "startPincruxOfferwallAdDetail": {
        String appkey = call.argument("appkey");
        offerwall.startPincruxOfferwallDetailActivity(activity, appkey);
        break;
      }

      case "startPincruxOfferwallContact": {
        offerwall.startPincruxContactActivity(activity);
        break;
      }

      case "setOfferwallType": {
        int type = call.argument("type");
        offerwall.setOfferwallType(type);
        break;
      }

      case "setEnableTab": {
        boolean isEnable = call.argument("isEnable");
        offerwall.setEnableTab(isEnable);
        break;
      }

      case "setOfferwallTitle": {
        String title = call.argument("title");
        offerwall.setOfferwallTitle(title);
        break;
      }

      case "setOfferwallThemeColor": {
        String color = call.argument("color");
        offerwall.setOfferwallThemeColor(color);
        break;
      }

      case "setEnableScrollTopButton": {
        boolean isEnable = call.argument("isEnable");
        offerwall.setEnableScrollTopButton(isEnable);
        break;
      }

      case "setAdDetail": {
        boolean isEnable = call.argument("isEnable");
        offerwall.setAdDetail(isEnable);
        break;
      }

      // 개인정보 수집 및 이용 동의 기능으로 인해 삭제됨
//                        case "setDisableTermsPopup": {
//                            boolean isDisable = call.argument("isDisable");
//                            offerwall.setDisableTermsPopup(isDisable);
//                            break;
//                        }

      case "setDisableCPS": {
        boolean isDisable = call.argument("isDisable");
        offerwall.setDisableCPS(isDisable);
        break;
      }

      case "setDarkMode": {
        int darkmode = call.argument("mode");
        offerwall.setDarkMode(darkmode);
        break;
      }

      default:
        throw new IllegalStateException("Unexpected value: " + call.method);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    Log.d("000onAttachedToActivity", "success");
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }
}
