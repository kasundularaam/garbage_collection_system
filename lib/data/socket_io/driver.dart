import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/configs/configs.dart';
import '../models/truck_location.dart';

class DriverSocket {
  io.Socket socket = io.io(socketAddress, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  sendData({required Stream<TruckLocation> dataStream}) async* {
    socket.connect();
    dataStream.listen(
      (TruckLocation data) {
        socket.emit(
          "truck",
          data,
        );
      },
    );
  }

  void dispose() {
    socket.dispose();
  }
}
