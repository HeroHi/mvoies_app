import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
@Singleton(as: DatabaseService)
class FirestoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var currentUser = Supabase.instance.client.auth.currentUser;
  @override
  Future<List<Map<String, dynamic>>> getData({required String path}) async {
    var response = await firestore
        .collection('users')
        .doc(currentUser!.id)
        .collection(path)
        .get();
    return response.docs
        .map(
          (e) => e.data(),
        )
        .toList();
  }

  @override
  Future<void> insertData(
      {required String path,
      required Map<String, dynamic> data,
      required String documentId}) async {
    await firestore
        .collection('users')
        .doc(currentUser!.id)
        .collection(path)
        .doc(documentId)
        .set(data);
  }
}
