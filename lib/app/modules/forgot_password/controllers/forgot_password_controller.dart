import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      if (emailC.text.isEmail) {
        isLoading.value = true;
        try {
          await auth.sendPasswordResetEmail(email: emailC.text);
          Get.back();
          Get.snackbar("Success",
              "Success to send an email, please check your inbox or spam");
        } catch (e) {
          Get.snackbar("Error", "Error to send an email");
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Please enter the correct email format");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "Error to send an email");
    }
  }
}
