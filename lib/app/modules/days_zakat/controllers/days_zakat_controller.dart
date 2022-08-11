import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DaysZakatController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final date = DateFormat("M").format(DateTime.now()).toString();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDaysMonthZakat() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("month", isEqualTo: int.parse(date))
        .where("uid", isEqualTo: uid)
        .where("type", isEqualTo: "Zakat")
        .snapshots();
  }
}
