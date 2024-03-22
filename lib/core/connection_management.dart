import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();

  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }
  return false;
}
