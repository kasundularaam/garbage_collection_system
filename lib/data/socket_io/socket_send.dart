import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/configs/configs.dart';

class SocketSend {
  io.Socket socket = io.io(socketAddress, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });
  final StreamController<String> socketResponse = StreamController<String>();

  Stream<void> sendData({required Stream<String> dataStream}) async* {
    socket.connect();
    dataStream.listen(
      (String data) {
        socket.emit(
          "event",
          data,
        );
      },
    );
  }

  void dispose() {
    socket.dispose();
    socketResponse.close();
  }
}
