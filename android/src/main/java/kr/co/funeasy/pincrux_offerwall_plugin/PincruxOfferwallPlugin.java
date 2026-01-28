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

import io.flutter.plugin.common.PluginRegistry;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

/** PincruxOfferwallPlugin */
public class PincruxOfferwallPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {

  private MethodChannel channel;
  private Activity activity;

  private PincruxOfferwall offerwall;

  // await / close callback 지원
  private Result pendingResult;
  private boolean waitingForClose = false;

  private static final int PINCRUX_REQ = 39127;

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
        return;
      }

      case "init": {
        String pubkey = call.argument("pubkey");
        String usrkey = call.argument("usrkey");
        offerwall.init(activity, pubkey, usrkey);
        result.success(null);
        return;
      }

      case "startOfferwall": {
        if (activity == null) {
          result.error("NOT_READY", "Activity is null", null);
          return;
        }
        if (waitingForClose) {
          result.error("ALREADY_OPEN", "Offerwall is already opened", null);
          return;
        }

        // 닫힐 때까지 Future를 잡아둠 (await)
        waitingForClose = true;
        pendingResult = result;

        Intent intent = new Intent(activity, ProxyOfferwallActivity.class);
        activity.startActivityForResult(intent, PINCRUX_REQ);

        // 여기서 result.success(null) 호출하면 await이 바로 풀리므로 호출 금지
        return;
      }

      case "startPincruxOfferwallViewType": {
        Intent intent = new Intent(activity, ViewTypeActivity.class);
        activity.startActivity(intent);
        result.success(null);
        return;
      }

      case "startPincruxOfferwallAdDetail": {
        String appkey = call.argument("appkey");
        offerwall.startPincruxOfferwallDetailActivity(activity, appkey);
        result.success(null);
        return;
      }

      case "startPincruxOfferwallContact": {
        offerwall.startPincruxContactActivity(activity);
        result.success(null);
        return;
      }

      case "setOfferwallType": {
        int type = call.argument("type");
        offerwall.setOfferwallType(type);
        result.success(null);
        return;
      }

      case "setEnableTab": {
        boolean isEnable = call.argument("isEnable");
        offerwall.setEnableTab(isEnable);
        result.success(null);
        return;
      }

      case "setOfferwallTitle": {
        String title = call.argument("title");
        offerwall.setOfferwallTitle(title);
        result.success(null);
        return;
      }

      case "setOfferwallThemeColor": {
        String color = call.argument("color");
        offerwall.setOfferwallThemeColor(color);
        result.success(null);
        return;
      }

      case "setEnableScrollTopButton": {
        boolean isEnable = call.argument("isEnable");
        offerwall.setEnableScrollTopButton(isEnable);
        result.success(null);
        return;
      }

      case "setAdDetail": {
        boolean isEnable = call.argument("isEnable");
        offerwall.setAdDetail(isEnable);
        result.success(null);
        return;
      }

      case "setDisableCPS": {
        boolean isDisable = call.argument("isDisable");
        offerwall.setDisableCPS(isDisable);
        result.success(null);
        return;
      }

      case "setDarkMode": {
        int darkmode = call.argument("mode");
        offerwall.setDarkMode(darkmode);
        result.success(null);
        return;
      }

      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    if (channel != null) channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    Log.d("PincruxOfferwallPlugin", "onAttachedToActivity");
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == PINCRUX_REQ) {
      finishOfferwallClosed();
      return true;
    }
    return false;
  }

  private void finishOfferwallClosed() {
    if (!waitingForClose) return;
    waitingForClose = false;

    // (2) 콜백 이벤트
    if (channel != null) channel.invokeMethod("offerwallClosed", null);

    // (1) await 완료
    if (pendingResult != null) {
      pendingResult.success(null);
      pendingResult = null;
    }
  }
}
