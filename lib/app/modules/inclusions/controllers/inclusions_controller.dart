import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:week_of_year/week_of_year.dart';

class InclusionsController extends GetxController {
  var week = DateTime.now();
  RxBool isLoading = false.obs;
  TextEditingController inclusionC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController dateC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void choseeDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2080),
    );
    if (pickedDate != null) {
      dateC.text = DateFormat("dd-MM-yyyy").format(pickedDate).toString();
    }
  }

  Future<void> processSubmit() async {
    if (inclusionC.text.isNotEmpty &&
        descC.text.isNotEmpty &&
        dateC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        if (auth.currentUser != null) {
          String uid = auth.currentUser!.uid;

          await firestore
              .collection("inclusion")
              .doc(DateTime.now().toIso8601String())
              .set({
            "uid": uid,
            "expense": inclusionC.text,
            "desc": descC.text,
            "date": dateC.text,
            "week": week.weekOfYear,
            "month": DateTime.now().month,
            "year": DateTime.now().year,
            "createdAt": DateTime.now().toIso8601String()
          });

          Get.offAllNamed(Routes.HOME);
          Get.snackbar("Success", "Your inclusions have been added");
        } else {
          Get.snackbar("Error", "Cannot get the user");
        }
      } catch (e) {
        Get.snackbar("Error", "Error to added your inclusions");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "All fields must be filled");
    }
  }
}
