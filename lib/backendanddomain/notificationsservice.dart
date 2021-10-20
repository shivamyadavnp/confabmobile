import 'package:confabmobile/softwarepackages.dart';

class NotificationsService {
  static FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static initialize() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    InitializationSettings initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    localNotificationsPlugin.initialize(initializationSettings);
  }

  static getIntitalMessage() async {
    await FirebaseMessaging.instance.getInitialMessage();
  }

  static handleForgroudNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      NotificationsService.displayNotification(message);
    });
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final notificationID = DateTime.now().millisecondsSinceEpoch ~/1000;
      
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "servicenotifications",
          "Service Notifications",
          channelDescription: "Notifications from Confab Service related to product and app",
          importance: Importance.high,
          priority: Priority.max,
        )
      );

      await localNotificationsPlugin.show(notificationID,
        message.notification.title,
        message.notification.body,
        notificationDetails,
      );
    } on Exception {
      return null;
    }
  }
}
