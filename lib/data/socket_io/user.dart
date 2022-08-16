import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/configs/configs.dart';
import '../models/truck_location.dart';

class UserSocket {
  io.Socket socket = io.io(socketUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  final StreamController<TruckLocation> streamController =
      StreamController<TruckLocation>();

  Stream<TruckLocation> getTruckLocations() async* {
    socket.connect();
    socket.on('user', (data) {
      TruckLocation location = TruckLocation.fromJson(data);
      streamController.sink.add(location);
    });
    yield* streamController.stream;
  }

  void dispose() {
    socket.dispose();
    streamController.close();
  }
}
