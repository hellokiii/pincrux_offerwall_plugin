package kr.co.funeasy.pincrux_offerwall_plugin;

import android.app.Activity;
import android.os.Bundle;

import com.pincrux.offerwall.PincruxOfferwall;

/**
 * Pincrux offerwall을 "프록시 Activity"에서 띄워서
 * 닫힘 시점을 100% 안정적으로 잡기 위한 Activity.
 *
 * - 최초 onPostResume: Pincrux 띄운 직후(무시)
 * - 두 번째 onPostResume: Pincrux 화면이 닫히고 돌아온 시점 -> finish()
 */
public class ProxyOfferwallActivity extends Activity {

  private boolean started = false;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // Pincrux offerwall 실행
    PincruxOfferwall.getInstance().startPincruxOfferwallActivity(this);
  }

  @Override
  protected void onPostResume() {
    super.onPostResume();

    if (!started) {
      started = true;
      return;
    }

    // Pincrux가 닫히고 복귀한 시점
    setResult(Activity.RESULT_OK);
    finish();
  }
}
