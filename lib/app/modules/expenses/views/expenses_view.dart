import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/expenses_controller.dart';

class ExpensesView extends GetView<ExpensesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EXPENSE'),
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
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Type : ",
                style: TextStyle(fontSize: 16),
              ),
              Obx(() => DropdownButton(
                    style: Theme.of(context).textTheme.headline6,
                    value: controller.valueChoose.value,
                    items: controller.listItem.map((String value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ));
                    }).toList(),
                    onChanged: (newValue) {
                      controller.setSelected(newValue.toString());
                    },
                  )),
            ],
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
