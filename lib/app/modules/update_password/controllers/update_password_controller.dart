import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool isNewVisible = false.obs;
  RxBool isCurVisible = false.obs;

  TextEditingController passC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();
  TextEditingController currentPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void processUpdatePass() async {
    if (passC.text.isNotEmpty && confirmPassC.text.isNotEmpty) {
      if (passC.text == confirmPassC.text) {
        isLoading.value = true;
        try {
          String email = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: email, password: currentPassC.text);

          await auth.currentUser!.updatePassword(passC.text);
          Get.back();
          Get.snackbar("Success", "Success to updated password");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Error", "The password provided is too weak.");
          } else if (e.code == 'wrong-password') {
            Get.snackbar(
                "Error", "Current password is Wrong provided for that user.");
          } else {
            Get.snackbar("Error", "${e.code}");
          }
        } catch (e) {
          Get.snackbar("Error", "Cannot updated the password");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
            "Error", "Confirm password is doesn't match with password");
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "All fields must be filled");
    }
  }
}
