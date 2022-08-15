import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/months_list_controller.dart';

class MonthsListView extends GetView<MonthsListController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(controller.id);
    return Scaffold(
        appBar: AppBar(
          title: Text('LIST MONTH AT YEAR'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            InkWell(
              // onTap: () => Get.toNamed(Routes.DAY_MONTH),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamMonthList(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "You have spent money",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.black87),
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
                        List<Map<String, dynamic>> result = [];
                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          Map<String, dynamic> data = {};
                          DateTime todayDate = DateTime.parse(snapshot
                              .data!.docs[i]
                              .data()["date"]
                              .split('-')
                              .reversed
                              .join());
                          data["date"] = todayDate;
                          data["createdAt"] =
                              snapshot.data!.docs[i].data()["createdAt"];
                          data["uid"] = snapshot.data!.docs[i].data()["uid"];
                          data["week"] = snapshot.data!.docs[i].data()["week"];
                          data["month"] =
                              snapshot.data!.docs[i].data()["month"];
                          data["year"] = snapshot.data!.docs[i].data()["year"];
                          data["type"] = snapshot.data!.docs[i].data()["type"];
                          data["expense"] =
                              snapshot.data!.docs[i].data()["expense"];
                          data["desc"] = snapshot.data!.docs[i].data()["desc"];
                          result.add(data);
                        }
                        result.sort((a, b) => a["date"].compareTo(b["date"]));
                        Map<String, dynamic> month = {};

                        for (int i = 1; i < 13; i++) {
                          List<dynamic> content = [];
                          for (int j = 0; j < result.length; j++) {
                            if (result[j]["month"] == i) {
                              content.add(result[j]);
                            }
                          }
                          // print(content);
                          month["month" + i.toString()] = content;
                        }

                        // int GrandTotal = 0;
                        Map<String, int> totalSpent = {};

                        // for (var i = 0; i < week.length; i++) {
                        //   GrandTotal +=
                        //       totalSpent["week${i + 1}"]?.toInt() ?? 0;
                        //   print(totalSpent["week${i + 1}"]);
                        // }
                        var f = NumberFormat.decimalPattern();
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.80,
                                child: ListView.builder(
                                    itemCount: month.length,
                                    itemBuilder: (context, index) {
                                      // controller.GrandTotal.value = 0;
                                      // for (var i = 0; i < week.length; i++) {
                                      int total = 0;
                                      if (month["month${index + 1}"] != null) {
                                        List<dynamic> monthj =
                                            month["month${index + 1}"];
                                        for (var j = 0;
                                            j < monthj.length;
                                            j++) {
                                          total +=
                                              int.parse(monthj[j]["expense"]);
                                        }
                                      }
                                      // print("month ke ${index 1} $total");
                                      totalSpent["month${index + 1}"] = total;
                                      //   controller.GrandTotal.value += total;
                                      // }

                                      // print(controller.GrandTotal.value);
                                      int id = index + 1;
                                      return Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          height: size.height * 0.17,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "You spent money in month ${id}",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      "Rp. ${f.format(totalSpent["month${index + 1}"])}",
                                                      style: TextStyle(
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.orange[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: size.height * 0.08,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("NOW AT YEAR ${DateTime.now().year}",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text("Error to Get Data"));
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}
