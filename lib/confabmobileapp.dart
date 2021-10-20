import 'package:confabmobile/softwarepackages.dart';

class ConfabMobileApp extends StatelessWidget {
  const ConfabMobileApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Confab Meetings",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      color: kPrimaryColor,
      home: const ConfabMeetingScreen(),
    );
  }
}
