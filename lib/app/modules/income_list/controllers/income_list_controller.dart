import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class IncomeListController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxInt id = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMonthIncome() async* {
    String uid = auth.currentUser!.uid;
    print(id);
    yield* firestore
        .collection("inclusion")
        .where("month", isEqualTo: id.value)
        .where("uid", isEqualTo: uid)
        .snapshots();
  }
}
