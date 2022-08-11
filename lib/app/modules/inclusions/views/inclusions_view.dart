import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/inclusions_controller.dart';

class InclusionsView extends GetView<InclusionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INCLUSION'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.inclusionC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Your Inclusion",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller.descC,
            maxLength: 80,
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
                    controller.isLoading.isFalse ? "SUBMIT" : "LOADING..."),
              )),
        ],
      ),
    );
  }
}
