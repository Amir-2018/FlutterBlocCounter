import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  // Test if the device have wifi or mobile connection
  if (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile) {
    return true;
  }
  return false;
}
