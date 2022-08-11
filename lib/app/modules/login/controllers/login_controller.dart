import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> processLogin() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
                title: "Unverified email",
                middleText:
                    "Please verified your account, if there is no message check spam",
                actions: [
                  TextButton(
                      onPressed: () => Get.back(), child: Text("CANCEL")),
                  ElevatedButton(
                      onPressed: () async {
                        await userCredential.user!.sendEmailVerification();
                      },
                      child: Text("RE-SEND EMAIL")),
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Error", "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Error", "Wrong password provided for that user.");
        } else {
          Get.snackbar("Error", "${e}");
        }
      } catch (e) {
        Get.snackbar("Erorr", "Cannot login, please contact the admin");
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "email and password is required!");
    }
  }
}
