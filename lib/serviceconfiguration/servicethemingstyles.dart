import 'package:confabmobile/softwarepackages.dart';

const kPrimaryColor = Color(0xFF366CF6);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: kTitleTextColor),
    ),
    iconTheme: const IconThemeData(color: kTitleTextColor),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: kTitleTextColor),
    hoverColor: kPrimaryColor.withOpacity(0.075),
    splashColor: kPrimaryColor.withOpacity(0.075),
    highlightColor: kPrimaryColor.withOpacity(0.075),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(kPrimaryColor),
      checkColor: MaterialStateProperty.all(Colors.white.withOpacity(0.95)),
      overlayColor: MaterialStateProperty.all(kPrimaryColor),
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF000000),
    backgroundColor: const Color(0xFF000000),
    cardColor: const Color(0xFF000000),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    canvasColor: const Color(0xFF000000),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white, displayColor: Colors.white.withOpacity(0.90)),
    hoverColor: kPrimaryColor.withOpacity(0.030),
    splashColor: kPrimaryColor.withOpacity(0.030),
    highlightColor: kPrimaryColor.withOpacity(0.030),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(kPrimaryColor),
      checkColor: MaterialStateProperty.all(Colors.white.withOpacity(0.95)),
      overlayColor: MaterialStateProperty.all(kPrimaryColor),
    ),
  );
}
