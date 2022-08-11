import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.passC,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.processLogin();
                  }
                },
                child:
                    Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
              )),
          SizedBox(height: 10),
          TextButton(
              onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
              child: Text("Forgot password")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account."),
              TextButton(
                onPressed: () => Get.offAllNamed(Routes.REGISTER),
                child: Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
