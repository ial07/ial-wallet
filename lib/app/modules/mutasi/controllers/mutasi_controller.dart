import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:week_of_year/week_of_year.dart';

class MutasiController extends GetxController {
  var date = DateTime.now();
  final dateDesc = DateFormat("MMMM").format(DateTime.now()).toString();

  var yesterday = DateFormat("dd-MM-yyyy")
      .format(DateTime.now().add(Duration(days: -1)))
      .toString();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var valueChoose = "January".obs;

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

  Map<String, int> key = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12
  };

  void setSelected(String value) {
    valueChoose.value = value;
    Get.reload();
    streamExpenseWeek();
    streamExpenseMonth();
    streamExpenseYesterday();
    streamInclusion();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseYesterday() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("date", isEqualTo: yesterday)
        .where("month", isEqualTo: key[valueChoose])
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseMonth() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("expense")
        .where("month", isEqualTo: key[valueChoose])
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamExpenseWeek() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("expense")
        .where("week", isEqualTo: date.weekOfYear)
        .where("month", isEqualTo: key[valueChoose])
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamInclusion() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("inclusion")
        .where("month", isEqualTo: key[valueChoose])
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  @override
  void onInit() {
    streamExpenseWeek();
    streamExpenseMonth();
    streamExpenseYesterday();
    streamInclusion();
    super.onInit();
  }
}
