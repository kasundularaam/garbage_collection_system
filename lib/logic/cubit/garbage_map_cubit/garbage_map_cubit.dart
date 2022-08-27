import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
import '../../../data/socket_io/driver.dart';

part 'garbage_map_state.dart';

class GarbageMapCubit extends Cubit<GarbageMapState> {
  final AppUser appUser;
  GarbageMapCubit({required this.appUser}) : super(GarbageMapInitial());

  final DriverSocket _driverSocket = DriverSocket();

  Future loadMap() async {
    try {
      emit(GarbageMapLoading());

      final HttpServices httpServices = HttpServices();
      final List<GarbageRequest> requests =
          await httpServices.getNewGarbageRequests();

      if (requests.isEmpty) {
        emit(GarbageMapAllCleaned());
      } else {
        LocationData truckLocation = await LocationServices.locationData;

        GarbageRequest nearest = nearestRequest(
            requests, truckLocation.latitude!, truckLocation.longitude!);

        Set<Marker> markers = {};

        Marker request = await getMarker(
            markerId: "request",
            icon: Strings.garbage,
            latLng: LatLng(nearest.latitude, nearest.longitude),
            info: "");

        markers.add(request);

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

        _driverSocket.sendData(appUser: appUser).listen((location) async {
          Marker truck = await getMarker(
              markerId: "truck",
              icon: Strings.truck,
              latLng: LatLng(location.lat, location.lng),
              info: "");
          markers.add(truck);
          Set<Marker> updated = markers
              .map((item) =>
                  item.markerId == const MarkerId("truck") ? truck : item)
              .toSet();
          markers.clear();
          markers.addAll(updated);

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
        throw "route_error".tr();
      }
    } catch (e) {
      throw "route_error".tr();
    }
  }

  dispose() {
    _driverSocket.dispose();
  }
}
