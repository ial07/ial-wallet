import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
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
          SizedBox(height: 20),
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
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
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => TextField(
              controller: controller.confirmPassC,
              obscureText: controller.isConfirmVisible.isFalse ? true : false,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.isConfirmVisible.toggle(),
                  icon: Icon(controller.isConfirmVisible.isFalse
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.processRegister();
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "REGISTER" : "LOADING..."),
              )),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already registered."),
              TextButton(
                onPressed: () => Get.offAllNamed(Routes.LOGIN),
                child: Text("LOGIN"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
