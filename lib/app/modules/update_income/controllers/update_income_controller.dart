import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class UpdateIncomeController extends GetxController {
  var week = DateTime.now();
  RxBool isLoading = false.obs;
  TextEditingController expenseC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  RxString createdAt = "".obs;

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
    if (expenseC.text.isNotEmpty &&
        descC.text.isNotEmpty &&
        dateC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        if (auth.currentUser != null) {
          String uid = auth.currentUser!.uid;

          Map<String, dynamic> data = {
            "uid": uid,
            "expense": expenseC.text,
            "desc": descC.text,
            "date": dateC.text,
            "updateAt": DateTime.now().toIso8601String()
          };
          await firestore
              .collection("inclusion")
              .where("createdAt", isEqualTo: createdAt.value)
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("inclusion")
                  .doc(element.id)
                  .update(data)
                  .then((value) {
                Get.offAllNamed(Routes.HOME);
                Get.snackbar("Success", "Your income have been updated");
              });
            });
          });
        } else {
          Get.snackbar("Error", "Cannot get the user");
        }
      } catch (e) {
        Get.snackbar("Error", "Error to updated your income");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "All fields must be filled");
    }
  }

  Future<void> deletedDocs() async {
    firestore
        .collection("inclusion")
        .where("createdAt", isEqualTo: createdAt.value)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("inclusion")
            .doc(element.id)
            .delete()
            .then((value) {
          Get.snackbar("Success", "Your income have been deleted");
          Get.offAllNamed(Routes.HOME);
        });
      });
    });
  }
}
