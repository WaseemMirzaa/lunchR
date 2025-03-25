import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/services/base_service.dart';

class CafaterisHistorySelectDateService extends BaseService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ParentsAddChildren>> fetchChildrenByCafateriaName(
      String cafeteriaName) async {

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("parentsChildren")
          .where("cafeteriaName", isEqualTo: cafeteriaName)
          .get();
// Check if data exists
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          print("Document ID: ${doc.id}");
          print("Data: ${doc.data()}");
        }
      } else {
        print("No matching documents found for cafeteriaName: $cafeteriaName");
      }
      List<ParentsAddChildren> childrenList = querySnapshot.docs
          .map((doc) => ParentsAddChildren.fromJson(doc.data()))
          .toList();

      return childrenList;
    } catch (e) {
      print("Error fetching children: $e");
      return [];
    }
  }

}