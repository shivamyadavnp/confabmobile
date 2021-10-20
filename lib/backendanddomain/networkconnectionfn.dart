import 'package:confabmobile/softwarepackages.dart';

class ConnectivityService {
  static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return true;
    }
    
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    
    return false;
  }
}
