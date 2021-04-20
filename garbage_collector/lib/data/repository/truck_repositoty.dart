import '../model/truck.dart';
import '../provider/firestore_api.dart';

class TruckRepository {
  final _db = FirestoreAPI(collection: 'truck');

  Future<Truck> add(Truck truck) async {
    final result = await _db.addData(truck.toMap());
    return truck.copyWith(id: result.id);
  }

  Stream<List<Truck>> getAll() => _db.getAll().map(
        (docs) => docs.docs
            .map(
              (doc) => Truck.fromMap(
                doc.data(),
              ),
            )
            .toList(),
      );
}
