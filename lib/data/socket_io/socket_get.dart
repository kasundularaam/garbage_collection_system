import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/configs/configs.dart';

class SocketGet {
  io.Socket socket = io.io(socketAddress, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  final StreamController<String> socketResponse = StreamController<String>();

  Stream<String> getData() async* {
    socket.connect();
    socket.on('event', (data) {
      socketResponse.sink.add(data as String);
    });
    yield* socketResponse.stream;
  }

  void dispose() {
    socket.dispose();
    socketResponse.close();
  }
}
