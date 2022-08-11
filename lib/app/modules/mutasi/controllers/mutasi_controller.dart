import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:week_of_year/week_of_year.dart';

class MutasiController extends GetxController {
  var date = DateTime.now();
  var currDate = DateTime.now().month.toString();
  var yesterday = DateFormat("dd-MM-yyyy")
      .format(DateTime.now().add(Duration(days: -1)))
      .toString();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseYesterday() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("date", isEqualTo: yesterday)
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseMonth() async* {
    String uid = auth.currentUser!.uid;
    print(yesterday);
    yield* firestore
        .collection("expense")
        .where("month", isEqualTo: int.parse(currDate))
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseWeek() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("week", isEqualTo: date.weekOfYear)
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamInclusion() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("inclusion")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }
}
