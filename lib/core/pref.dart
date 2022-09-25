import 'package:get_storage/get_storage.dart';

class Preference {
  static final prefs = GetStorage();
  static const loggedInFlag = 'loginFlag';
  static const userIdFlag = 'userIdFlag';
  static const tokenIdFlag = 'tokentIdFlag';


  static bool getLoggedInFlag() {
    return prefs.read(loggedInFlag) ?? false;
  }

  static void setLoggedInFlag(bool value) {
    prefs.write(loggedInFlag, value);
  }

static String getTokenFlag() {
    return prefs.read(tokenIdFlag) ?? '';
  }

  static void setTokenFlag(String value) {
    prefs.write(tokenIdFlag, value);
  }

  static void clearAll() {
    prefs.erase();
  }
}
