import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:path_provider/path_provider.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController nohpC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fs.FirebaseStorage storage = fs.FirebaseStorage.instance;

  final ImagePicker pickImg = ImagePicker();

  XFile? image;

  void imagePicker() async {
    image = await pickImg.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  void deleteImage(String uid) async {
    try {
      await firestore.collection("user").doc(uid).update({
        "image": FieldValue.delete(),
      });
      update();
      Get.snackbar("Success", "success deleted the picture");
    } catch (e) {
      Get.snackbar("Error", "Cannot deleted this picture");
    }
  }

  Future<void> updateProfile(String uid) async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        nohpC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
          "nohp": nohpC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref("${uid}/profile.${ext}").putFile(file);
          String UrlImage =
              await storage.ref("${uid}/profile.${ext}").getDownloadURL();

          data.addAll({"image": UrlImage});
        }
        firestore.collection("user").doc(uid).update(data);
        Get.back();
        Get.snackbar("Success", "Success updated the user");
      } catch (e) {
        Get.snackbar("Error", "Error while updated the user");
      }
    }
  }
}
