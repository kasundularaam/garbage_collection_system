import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbage_collection_system/data/models/truck_location.dart';

class MyFireStore {
  static CollectionReference trucks =
      FirebaseFirestore.instance.collection('trucks');

  static Future<void> updateTruck(
      {required TruckLocation truckLocation}) async {
    try {
      await trucks.doc("vZwV3wpe3h9UixEqbM0j").update(truckLocation.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  static Stream<TruckLocation> getLocations() async* {
    try {
      Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot =
          FirebaseFirestore.instance
              .collection('trucks')
              .doc('vZwV3wpe3h9UixEqbM0j')
              .snapshots();

      yield* snapshot.map((event) => TruckLocation.fromMap(event.data()!));
    } catch (e) {
      throw e.toString();
    }
  }
}
