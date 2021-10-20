import 'package:confabmobile/softwarepackages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await SharedPreferencesService.init();
  await NotificationsService.initialize();
  FirebaseMessaging.onBackgroundMessage((remoteMessage) async {
    if (remoteMessage.data["parsedValue"] == "update") {
      await launch(ConfigurationValues.appStoreLink);
    }
    if (remoteMessage.data["parsedValue"] == "rate") {
      await launch(ConfigurationValues.appStoreLink);
    }
    if (remoteMessage.data["parsedValue"] == "sendFeedback") {
      await launch(ConfigurationValues.sendFeedbackLink);
    }
    return null;
  });
  ErrorWidget.builder = (errorDetails) => const Scaffold(
    body: Center(child: Text("Something went error!!")),
  );
  runApp(const ConfabMobileApp());
}
