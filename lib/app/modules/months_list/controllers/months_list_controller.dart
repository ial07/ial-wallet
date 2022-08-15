import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonthsListController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final date = DateFormat("yyyy").format(DateTime.now()).toString();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMonthList() async* {
    String uid = auth.currentUser!.uid;
    print(date);
    yield* firestore
        .collection("expense")
        .where("year", isEqualTo: int.parse(date))
        .where("uid", isEqualTo: uid)
        .snapshots();
  }
}
