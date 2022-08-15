import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/components/BottomBar.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/mutasi_controller.dart';

class MutasiView extends GetView<MutasiController> {
  var yesterday = DateTime.now().add(Duration(days: -1));
  var month = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('MUTATIONS'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("FILTER : ", style: TextStyle(fontSize: 22)),
                  Obx(() => DropdownButton(
                        style: Theme.of(context).textTheme.headline6,
                        value: controller.valueChoose.value,
                        items: controller.monthsInYear.map((String value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 26),
                              ));
                        }).toList(),
                        onChanged: (newValue) {
                          controller.setSelected(newValue.toString());
                          Get.offAndToNamed(Routes.MUTASI);
                        },
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(Routes.DAY_MONTH),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamExpenseYesterday(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs.length == 0 ||
                          snapshot.data == null) {
                        return Container(
                          height: size.height * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "You have spent yesterday",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.black87),
                                    ),
                                    Text(
                                      "Rp. 0",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      var dataLength = snapshot.data!.docs.length;

                      var f = NumberFormat.decimalPattern();
                      int total = 0;
                      for (int i = 0; i < dataLength; i++) {
                        Map<String, dynamic> Datas =
                            snapshot.data!.docs[i].data();
                        total += int.parse(Datas["expense"]);
                      }
                      return Container(
                        height: size.height * 0.17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You have spent yesterday",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.black87),
                                  ),
                                  Text(
                                    "Rp. ${f.format(total)}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateFormat("EE/dd-MMM").format(yesterday)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.DAY_MONTH),
                                    child: Text(
                                      "VIEW MORE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("No data"));
                    }
                  }),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(Routes.WEEK_MONTH),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamExpenseWeek(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs.length == 0 ||
                          snapshot.data == null) {
                        return Container(
                          height: size.height * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "You have spent a weeks",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.black87),
                                    ),
                                    Text(
                                      "Rp. 0",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      var dataLength = snapshot.data!.docs.length;

                      var f = NumberFormat.decimalPattern();
                      int total = 0;
                      for (int i = 0; i < dataLength; i++) {
                        Map<String, dynamic> Datas =
                            snapshot.data!.docs[i].data();
                        total += int.parse(Datas["expense"]);
                      }
                      return Container(
                        height: size.height * 0.17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You have spent a weeks",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.black87),
                                  ),
                                  Text(
                                    "Rp. ${f.format(total)}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.WEEK_MONTH),
                                    child: Text(
                                      "VIEW MORE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("No data"));
                    }
                  }),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(Routes.MONTHS_LIST),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamExpenseMonth(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs.length == 0 ||
                          snapshot.data == null) {
                        return Container(
                          height: size.height * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "You have spent a months",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.black87),
                                    ),
                                    Text(
                                      "Rp. 0",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      var dataLength = snapshot.data!.docs.length;

                      var f = NumberFormat.decimalPattern();
                      int total = 0;
                      for (int i = 0; i < dataLength; i++) {
                        Map<String, dynamic> Datas =
                            snapshot.data!.docs[i].data();
                        total += int.parse(Datas["expense"]);
                      }
                      return Container(
                        height: size.height * 0.17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You have spent a months",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.black87),
                                  ),
                                  Text(
                                    "Rp. ${f.format(total)}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.MONTHS_LIST),
                                    child: Text(
                                      "VIEW MORE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("No data"));
                    }
                  }),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(Routes.MONTHS_INCOME),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamInclusion(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs.length == 0 ||
                          snapshot.data == null) {
                        return Container(
                          height: size.height * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your income",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.black87),
                                    ),
                                    Text(
                                      "Rp. 0",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      var dataLength = snapshot.data!.docs.length;

                      var f = NumberFormat.decimalPattern();
                      int total = 0;
                      for (int i = 0; i < dataLength; i++) {
                        Map<String, dynamic> Datas =
                            snapshot.data!.docs[i].data();
                        total += int.parse(Datas["expense"]);
                      }
                      return Container(
                        height: size.height * 0.17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your income",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.black87),
                                  ),
                                  Text(
                                    "Rp. ${f.format(total)}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.MONTHS_INCOME),
                                    child: Text(
                                      "VIEW MORE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("No data"));
                    }
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
