import UIKit
import Flutter
import UserNotifications
import FirebaseCore // Make sure FirebaseCore is imported
import FirebaseMessaging // Make sure FirebaseMessaging is imported

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Initialize Firebase IF NOT already done in Dart's main() BEFORE runApp()
    // Usually FirebaseApp.configure() is not needed here if initialized in Dart.
    // FirebaseApp.configure()

    // Request notification permissions and set delegate
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    // Register for remote notifications. Must happen AFTER FirebaseApp.configure()
    // if you configure here, otherwise it should be fine.
     application.registerForRemoteNotifications()


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // --- THIS IS THE CRUCIAL PART if swizzling is disabled ---
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      // Pass device token to Firebase Messaging
      Messaging.messaging().apnsToken = deviceToken // <<-- MAKE SURE THIS LINE IS PRESENT AND UNCOMMENTED
      print("Registered for remote notifications with APNS token.")
      // You might have other code here to send the APNS token directly
      // to your server if needed, but Firebase needs it too.
  }
  // --- End Crucial Part ---

  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register for remote notifications: \(error.localizedDescription)")
  }

  // Optional: Handle background notification data payload if needed here,
  // though firebase_messaging plugin often handles this sufficiently.
  // override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  //     // Pass notification to Firebase
  //     Messaging.messaging().appDidReceiveMessage(userInfo)
  //     // Handle your custom data payload here if necessary
  //     completionHandler(.newData)
  // }
}