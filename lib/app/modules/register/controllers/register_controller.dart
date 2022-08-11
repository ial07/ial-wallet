import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool isConfirmVisible = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> processRegister() async {
    if (emailC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        nohpC.text.isNotEmpty &&
        confirmPassC.text.isNotEmpty) {
      if (emailC.text.isEmail) {
        isLoading.value = true;
        if (passC.text == confirmPassC.text) {
          try {
            UserCredential userCredential =
                await auth.createUserWithEmailAndPassword(
              email: emailC.text,
              password: passC.text,
            );

            if (userCredential != null) {
              String uid = userCredential.user!.uid;

              await firestore.collection("user").doc(uid).set({
                "name": nameC.text,
                "email": emailC.text,
                "password": passC.text,
                "nohp": nohpC.text,
                "uid": uid,
                "createdAt": DateTime.now().toIso8601String(),
              });

              await userCredential.user!.sendEmailVerification();

              Get.offAllNamed(Routes.LOGIN);
              Get.snackbar("Success",
                  "Your is registered, please verified your account first");
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              Get.snackbar("Error", "The password provided is too weak.");
            } else if (e.code == 'email-already-in-use') {
              Get.snackbar(
                  "Error", "The account already exists for that email.");
            }
          } catch (e) {
            Get.snackbar("Error", "Cannot create an account");
          } finally {
            isLoading.value = false;
          }
        } else {
          isLoading.value = false;
          Get.snackbar(
              "Error", "Confirm password must be the same as the password");
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Please enter the correct email format");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "All fields must be filled");
    }
  }
}
