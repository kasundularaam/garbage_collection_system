import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/strings.dart';
import '../../../core/themes/app_colors.dart';
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

  DriverSocket? _driverSocket;

  Future loadMap({required AppUser appUser}) async {
    try {
      emit(GarbageMapLoading());

      Set<Marker> markers = {};

      HttpServices httpServices = HttpServices();
      final List<GarbageRequest> requests =
          await httpServices.getNewGarbageRequests();

      if (requests.isEmpty) {
        emit(GarbageMapAllCleaned());
      } else {
        LocationData truckLocation = await LocationServices.locationData;

        GarbageRequest nearest = nearestRequest(
            requests, truckLocation.latitude!, truckLocation.longitude!);

        Marker request = await getMarker(
            markerId: "request",
            icon: Strings.garbage,
            latLng: LatLng(nearest.latitude, nearest.longitude),
            info: "");

        markers.add(request);

        _driverSocket = DriverSocket(appUser: appUser);
        Stream<TruckLocation> locationStream = _driverSocket!.sendData();

        Map<PolylineId, Polyline> polylines = {};

        LatLng startLocation =
            LatLng(truckLocation.latitude!, truckLocation.longitude!);
        LatLng endLocation = LatLng(nearest.latitude, nearest.longitude);
        List<LatLng> polylineCoordinates =
            await polylineCords(startLocation, endLocation);

        PolylineId id = const PolylineId("poly");
        Polyline polyline = Polyline(
          polylineId: id,
          color: AppColors.primaryColor,
          points: polylineCoordinates,
          width: 5,
        );

        polylines[id] = polyline;

        locationStream.listen((location) async {
          Marker user = await getMarker(
              markerId: "truck",
              icon: Strings.truck,
              latLng: LatLng(location.lat, location.lng),
              info: "");
          markers.add(user);

          emit(
            GarbageMapLoaded(
                request: nearest,
                markers: markers,
                truckLocation:
                    LatLng(truckLocation.latitude!, truckLocation.longitude!),
                polylines: polylines),
          );
        });
      }
    } catch (e) {
      dispose();
      emit(GarbageMapFailed(errorMsg: e.toString()));
    }
  }

  Future<List<LatLng>> polylineCords(
      LatLng startLocation, LatLng endLocation) async {
    try {
      List<LatLng> polylineCoordinates = [];

      PolylinePoints polylinePoints = PolylinePoints();
      String googleAPiKey = "AIzaSyC2juTDRi7wjau4qkfjPWJeEevTqTTWPt8";

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
        return polylineCoordinates;
      } else {
        throw "unable to get coordinates";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  dispose() {
    _driverSocket!.dispose();
  }
}
