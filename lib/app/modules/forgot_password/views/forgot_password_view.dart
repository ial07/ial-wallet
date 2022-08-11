import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORGOT PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "type right email address to change your password!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Obx(() => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.sendEmail();
                }
              },
              child: Text(
                  controller.isLoading.isFalse ? "SUBMIT" : "LOADING..."))),
        ],
      ),
    );
  }
}
