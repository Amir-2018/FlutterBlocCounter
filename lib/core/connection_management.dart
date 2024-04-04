import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.wifi) || connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
  }
  return false;
}

StreamController<bool> connectionStream = StreamController<bool>.broadcast();
void checkConnectionAndUpdate() async {
  bool isConnected = await checkConnection();
  connectionStream.add(isConnected);
}

void startConnectionCheckTimer() {
  const Duration checkInterval = Duration(seconds: 1); // Adjust the interval as needed
  Timer.periodic(checkInterval, (timer) {
    checkConnectionAndUpdate();
  });
}