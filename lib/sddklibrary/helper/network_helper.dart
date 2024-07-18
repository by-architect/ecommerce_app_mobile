import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  final Connectivity _connectivity = Connectivity();

  Future<NetworkResult> isConnectedToNetwork() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return NetworkResult(result != ConnectivityResult.none, result);
  }
}

class NetworkResult {
  final bool isConnected;
  final List<ConnectivityResult> connections;

  NetworkResult(this.isConnected, this.connections);
}
