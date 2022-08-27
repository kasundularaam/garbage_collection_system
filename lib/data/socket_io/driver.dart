import 'dart:async';
import 'package:garbage_collection_system/data/models/app_user.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/configs/configs.dart';
import '../location/location_services.dart';
import '../models/truck_location.dart';

class DriverSocket {
  io.Socket socket = io.io(socketUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  final StreamController<TruckLocation> socketResponse =
      StreamController<TruckLocation>.broadcast();

  void addResponse({required TruckLocation truckLocation}) =>
      socketResponse.sink.add(truckLocation);

  Stream<TruckLocation> getResponse() => socketResponse.stream;

  Stream<TruckLocation> sendData({required AppUser appUser}) async* {
    socket.connect();

    LocationServices.locationStream.listen((location) {
      TruckLocation truckLocation = TruckLocation(
        id: appUser.id,
        name: appUser.username,
        lat: location.latitude!,
        lng: location.longitude!,
        mobileNum: appUser.mobileNo,
      );
      addResponse(
        truckLocation: truckLocation,
      );
      socket.emit(
        "truck",
        truckLocation.toMap(),
      );
    });
    yield* getResponse();
  }

  void dispose() {
    socketResponse.close();
    socket.dispose();
  }
}
