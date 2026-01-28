import Flutter
import UIKit
import PincruxOfferwall

public class PincruxOfferwallPlugin: NSObject, FlutterPlugin, UIAdaptivePresentationControllerDelegate {
  var offerwall: PincruxOfferwallSDK?
  private var controller: FlutterViewController?

  private var channel: FlutterMethodChannel?

  // await 지원용
  private var pendingResult: FlutterResult?
  private var waitingForClose: Bool = false

  // dismiss 감지 보강용
  private weak var observedPresentedVC: UIViewController?
  private var closePollTimer: Timer?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let ch = FlutterMethodChannel(name: "pincrux_offerwall_plugin",
                                 binaryMessenger: registrar.messenger())
    let instance = PincruxOfferwallPlugin()
    instance.channel = ch
    registrar.addMethodCallDelegate(instance, channel: ch)

    // controller 설정(기존 방식 유지)
    if let viewController = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController {
      instance.controller = viewController
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)

    case "init":
      if let args = call.arguments as? [String: Any],
         let pubkey = args["pubkey"] as? String,
         let usrkey = args["usrkey"] as? String {
        self.offerwall = PincruxOfferwallSDK.initWithPubkeyAndUsrkey(pubkey, usrkey)
      }
      result(nil)

    case "setOfferwallViewControllerType":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let type = args["type"] as? Int {
        if type == 1 {
          self.offerwall?.setViewControllerType(.Modal)
        } else if type == 2 {
          self.offerwall?.setViewControllerType(.ViewType)
        }
      }
      result(nil)

    case "startOfferwall":
      guard self.isOfferwallNotNil(), let vc = controller else {
        result(FlutterError(code: "NOT_READY", message: "Offerwall or controller is nil", details: nil))
        return
      }
      if waitingForClose {
        result(FlutterError(code: "ALREADY_OPEN", message: "Offerwall is already presented", details: nil))
        return
      }

      // ✅ 여기서 result를 바로 끝내지 말고 저장해둠 (await 걸면 닫힐 때까지 대기)
      waitingForClose = true
      pendingResult = result

      DispatchQueue.main.async {
        self.offerwall?.startOfferwall(vc: vc)

        // SDK가 present를 내부에서 하는 경우가 많아서, 약간 뒤에 presented VC를 잡아 delegate 부착
        self.attachDismissObserver(retryCount: 6)
        self.startClosePolling()
      }

    case "startPincruxOfferwallViewType":
      if self.isOfferwallNotNil(), let vc = controller {
        let viewtypeVC = UIViewController(nibName: "ViewTypeViewController", bundle: nil) as? ViewTypeViewController ?? ViewTypeViewController()
        viewtypeVC.presentationController?.delegate = self // ✅ 이것도 닫힘 감지 가능
        vc.modalPresentationStyle = .fullScreen
        vc.present(viewtypeVC, animated: true)
      }
      result(nil)

    case "startPincruxOfferwallAdDetail":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let appkey = args["appkey"] as? String,
         let vc = controller {
        self.offerwall?.startOfferwallDetailVC(vc: vc, appKey: appkey)
      }
      result(nil)

    case "startPincruxOfferwallContact":
      if self.isOfferwallNotNil(), let vc = controller {
        self.offerwall?.startOfferwallContactVC(vc: vc)
      }
      result(nil)

    case "setOfferwallType":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let type = args["type"] as? Int {
        if type == 2 {
          self.offerwall?.setOfferwallType(.BAR_PREMIUM_TYPE)
        } else if type == 3 {
          self.offerwall?.setOfferwallType(.PREMIUM_TYPE)
        } else {
          self.offerwall?.setOfferwallType(.BAR_TYPE)
        }
      }
      result(nil)

    case "setEnableTab":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let isEnable = args["isEnable"] as? Bool {
        self.offerwall?.setEnableTab(isEnable)
      }
      result(nil)

    case "setOfferwallTitle":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let title = args["title"] as? String {
        self.offerwall?.setOfferwallTitle(title)
      }
      result(nil)

    case "setOfferwallThemeColor":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let color = args["color"] as? String {
        self.offerwall?.setThemeColor(color)
      }
      result(nil)

    case "setEnableScrollTopButton":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let isEnable = args["isEnable"] as? Bool {
        self.offerwall?.setEnableScrollTopButton(isEnable)
      }
      result(nil)

    case "setAdDetail":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let isEnable = args["isEnable"] as? Bool {
        self.offerwall?.setAdDetail(isEnable)
      }
      result(nil)

    case "setDisableCPS":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let isDisable = args["isDisable"] as? Bool {
        self.offerwall?.setDisableCPS(isDisable)
      }
      result(nil)

    case "setDarkMode":
      if self.isOfferwallNotNil(),
         let args = call.arguments as? [String: Any],
         let mode = args["mode"] as? Int {
        if mode == 0 {
          self.offerwall?.setDarkMode(.AUTO)
        } else if mode == 2 {
          self.offerwall?.setDarkMode(.DARK_ONLY)
        } else {
          self.offerwall?.setDarkMode(.LIGHT_ONLY)
        }
      }
      result(nil)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func isOfferwallNotNil() -> Bool {
    return self.offerwall != nil
  }

  // MARK: - Dismiss detection

  private func attachDismissObserver(retryCount: Int) {
    guard retryCount > 0, let root = controller else { return }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
      // presented 체인을 끝까지 따라가서 최상단 VC 찾기
      var top: UIViewController = root
      while let presented = top.presentedViewController {
        top = presented
      }

      // root 자신이면 아직 offerwall이 안 떴을 가능성
      if top === root {
        self.attachDismissObserver(retryCount: retryCount - 1)
        return
      }

      self.observedPresentedVC = top
      top.presentationController?.delegate = self
    }
  }

  public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    finishOfferwallClosed()
  }

  private func startClosePolling() {
    closePollTimer?.invalidate()
    closePollTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      guard self.waitingForClose else { return }

      // observedPresentedVC가 사라졌거나, controller에서 더 이상 presented가 없으면 종료로 판단
      let root = self.controller
      let stillPresented = root?.presentedViewController != nil
      let observedGone = (self.observedPresentedVC?.presentingViewController == nil)

      if !stillPresented || observedGone {
        self.finishOfferwallClosed()
      }
    }
  }

  private func finishOfferwallClosed() {
    guard waitingForClose else { return }
    waitingForClose = false

    closePollTimer?.invalidate()
    closePollTimer = nil
    observedPresentedVC = nil

    // ✅ (2) 콜백 이벤트도 쏘고
    channel?.invokeMethod("offerwallClosed", arguments: nil)

    // ✅ (1) await도 풀어줌
    pendingResult?(nil)
    pendingResult = nil
  }
}
