import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future addUserDetails(Map<String, dynamic> userInfoMap, String id){
    return FirebaseFirestore.instance
      .collection("users")
      .doc(id)
      .set(userInfoMap);
  }

  Future addProduct(Map<String, dynamic> userInfoMap, String categoryname){
    return FirebaseFirestore.instance
      .collection(categoryname)
      .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getProducts(String category)async{
    return await FirebaseFirestore.instance
      .collection(category)
      .snapshots();
  }
}