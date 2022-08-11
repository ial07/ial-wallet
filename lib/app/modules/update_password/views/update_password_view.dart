import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Obx(
            () => TextField(
              controller: controller.passC,
              obscureText: controller.isVisible.isFalse ? true : false,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.isVisible.toggle(),
                  icon: Icon(controller.isVisible.isFalse
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => TextField(
              controller: controller.confirmPassC,
              obscureText: controller.isNewVisible.isFalse ? true : false,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.isNewVisible.toggle(),
                  icon: Icon(controller.isNewVisible.isFalse
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => TextField(
              controller: controller.currentPassC,
              obscureText: controller.isCurVisible.isFalse ? true : false,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.isCurVisible.toggle(),
                  icon: Icon(controller.isCurVisible.isFalse
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                labelText: "Current Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.processUpdatePass();
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
