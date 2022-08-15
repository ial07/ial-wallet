import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_income_controller.dart';

class UpdateIncomeView extends GetView<UpdateIncomeController> {
  Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // print(data);
    controller.expenseC.text = data["expense"];
    controller.descC.text = data["desc"];
    controller.createdAt.value = data["createdAt"];
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE INCOME'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.expenseC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Your expense",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller.descC,
            maxLength: 30,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Descriptions",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: controller.dateC,
            autocorrect: false,
            decoration: InputDecoration(
                labelText: "Select date",
                icon: Icon(Icons.calendar_month_rounded)),
            onTap: () {
              controller.choseeDate();
            },
          ),
          SizedBox(height: 20),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.processSubmit();
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "UPDATED" : "LOADING..."),
              )),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              Get.defaultDialog(
                  title: "Are you sure?",
                  middleText: "Document will be deleted",
                  actions: [
                    TextButton(onPressed: () => Get.back(), child: Text("NO")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          controller.deletedDocs();
                        },
                        child: Text("YES")),
                  ]);
            },
            child: Text("DELETE"),
          )
        ],
      ),
    );
  }
}
