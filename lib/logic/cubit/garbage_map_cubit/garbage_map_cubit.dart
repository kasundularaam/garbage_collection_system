import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/http/http_services.dart';
import '../../../data/location/location_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/garbage_request.dart';
import '../../../data/models/truck_location.dart';
import '../../../data/socket_io/driver.dart';

part 'garbage_map_state.dart';

class GarbageMapCubit extends Cubit<GarbageMapState> {
  GarbageMapCubit() : super(GarbageMapInitial());

  DriverSocket? driverSocket;

  StreamController<TruckLocation> streamController =
      StreamController<TruckLocation>();

  Future loadMap({required AppUser appUser}) async {
    try {
      emit(GarbageMapLoading());
      driverSocket = DriverSocket();
      Set<Marker> markers = {};

      HttpServices httpServices = HttpServices();
      final List<GarbageRequest> requests =
          await httpServices.getNewGarbageRequests();

      LocationData truckLocation = await LocationServices.locationData;

      GarbageRequest nearest = nearestRequest(
          requests, truckLocation.latitude!, truckLocation.longitude!);

      Marker request = await getMarker(
          markerId: "request",
          icon: Strings.garbage,
          latLng: LatLng(nearest.latitude, nearest.longitude),
          info: "");

      markers.add(request);

      Stream<LocationData> locationStream = LocationServices.locationStream;

      locationStream.listen((location) async {
        Marker user = await getMarker(
            markerId: "truck",
            icon: Strings.truck,
            latLng: LatLng(location.latitude!, location.longitude!),
            info: "");
        markers.add(user);

        if (driverSocket != null) {
          streamController.sink.add(
            TruckLocation(
              id: appUser.id,
              name: appUser.username,
              lat: location.latitude!,
              lng: location.longitude!,
              mobileNum: appUser.mobileNo,
            ),
          );
          driverSocket!.sendData(dataStream: streamController.stream);
        }

        PolylinePoints polylinePoints = PolylinePoints();
        String googleAPiKey = "AIzaSyArOcw3CWHD7pO800bfj3hF3Qpap5j8A2Q";
        Map<PolylineId, Polyline> polylines = {};

        LatLng startLocation = LatLng(location.latitude!, location.longitude!);
        LatLng endLocation = LatLng(nearest.latitude, nearest.longitude);

        List<LatLng> polylineCoordinates = [];

        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(startLocation.latitude, startLocation.longitude),
          PointLatLng(endLocation.latitude, endLocation.longitude),
          travelMode: TravelMode.driving,
        );

        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        }

        PolylineId id = const PolylineId("poly");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.deepPurpleAccent,
          points: polylineCoordinates,
          width: 8,
        );

        polylines[id] = polyline;

        emit(
          GarbageMapLoaded(
            request: nearest,
            markers: markers,
            truckLocation:
                LatLng(truckLocation.latitude!, truckLocation.longitude!),
            polylines: polylines,
          ),
        );
      });
    } catch (e) {
      emit(GarbageMapFailed(errorMsg: e.toString()));
    }
  }
}
