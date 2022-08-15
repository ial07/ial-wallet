import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeekMonthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final date = DateFormat("M").format(DateTime.now()).toString();
  RxInt GrandTotal = 0.obs;
  // Map<String, int> totalSpent = {};

  // int total() {
  //   for (var i = 0; i < 52; i++) {
  //     GrandTotal += totalSpent["week${i + 1}"]?.toInt() ?? 0;
  //     print(totalSpent["week${i + 1}"]);
  //   }
  //   print(GrandTotal);
  //   return GrandTotal;
  // }

  final valueChoose = "August".obs;
  var monthsInYear = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  void setSelected(String value) {
    valueChoose.value = value;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamWeeksAll() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("month", isEqualTo: int.parse(date))
        .where("uid", isEqualTo: uid)
        .snapshots();
  }
}
