import 'package:confabmobile/softwarepackages.dart';

class SharedPreferencesService {
  static SharedPreferences sharedPreferences;

  static const keyUsername = 'username';
  static const keyPhotoLink = 'photolink';
  static const keyEmailAddress = 'emailaddress';

  static Future init() async => sharedPreferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async => await sharedPreferences.setString(keyUsername, username);

  static String getUsername() => sharedPreferences.getString(keyUsername);

  static Future setPhotoLink(String photoUrl) async => await sharedPreferences.setString(keyPhotoLink, photoUrl);

  static String getPhotoLink() => sharedPreferences.getString(keyPhotoLink);

  static Future setEmailAddress(String emailAddress) async => await sharedPreferences.setString(keyEmailAddress, emailAddress);

  static String getEmailAddress() => sharedPreferences.getString(keyEmailAddress);
}
