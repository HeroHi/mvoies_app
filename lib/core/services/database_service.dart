abstract class DatabaseService{
  Future<dynamic> getData({required String path});
  Future<void> insertData( {required String path, required Map<String, dynamic> data,required String documentId});
  Future<void> updatePhone(String phone);
  Future<String> getPhone();
}