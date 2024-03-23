import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  //final ConnectivityResult connectivityResult =
  //await Connectivity().checkConnectivity();
  // Test if the device have wifi or mobile connection
  ConnectivityResult.values.map((connectionType) {
    if (connectionType == ConnectivityResult.wifi ||
        connectionType == ConnectivityResult.mobile) {
      return true;
    }
  });
  return false;
}
