import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final date = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseToday() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("date", isEqualTo: date)
        .where("uid", isEqualTo: uid)
        .snapshots();
  }
}
