import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = user["email"];
    controller.nameC.text = user["name"];
    controller.nohpC.text = user["nohp"];
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.emailC,
            readOnly: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Full Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.nohpC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "No HP",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Photo profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["image"] != null && user["image"] != "") {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                                height: 100,
                                width: 100,
                                child: Image.network(user["image"])),
                          ),
                          TextButton(
                            onPressed: () =>
                                controller.deleteImage(user["uid"]),
                            child: Text(
                              "DELETE",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text("No image.");
                    }
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    controller.imagePicker();
                  },
                  child: Icon(Icons.camera_alt)),
            ],
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updateProfile(user["uid"]);
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "UPDATE" : "LOADING..."),
              )),
        ],
      ),
    );
  }
}
