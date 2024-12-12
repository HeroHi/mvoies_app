import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/services/database_service.dart';
@Singleton(as: DatabaseService)
class FirestoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;
  @override
  Future<List<Map<String, dynamic>>> getData({required String path}) async {
    var response = await firestore
        .collection('users')
        .doc(currentUser!.uid)
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
        .doc(currentUser!.uid)
        .collection(path)
        .doc(documentId)
        .set(data);
  }

  @override
  Future<void> updatePhone(String phone) async {
    currentUser!.reload();
    firestore.collection('users').doc(currentUser!.uid).set({'phone':phone});
  }

  @override
  Future<String> getPhone() async{
    currentUser!.reload();
   var response = await firestore.collection('users').doc(currentUser!.uid).get();
   return response['phone'];

  }
}
