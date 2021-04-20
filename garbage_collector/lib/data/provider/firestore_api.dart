import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreAPI {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final String collection;
  FirestoreAPI({
    @required this.collection,
  });

  Future<DocumentReference> addData(Map<String, dynamic> doc) async {
    return await _firebaseFirestore.collection(collection).add(doc);
  }

  Future<void> setData(String id, Map<String, dynamic> doc) async {
    return await _firebaseFirestore.doc(id).set(doc);
  }

  Stream<QuerySnapshot> getAll() {
    return _firebaseFirestore.collection(collection).snapshots();
  }

  Future<DocumentReference> getSingle({@required String documentId}) async {
    return _firebaseFirestore.collection(collection).doc(documentId);
  }
}
