import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/week_month_controller.dart';

class WeekMonthView extends GetView<WeekMonthController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('LIST WEEKS'),
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
                    stream: controller.streamWeeksAll(),
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
                                        "You have spent a week",
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
                        Map<String, dynamic> week = {};

                        for (int i = 1; i < 53; i++) {
                          List<dynamic> content = [];
                          for (int j = 0; j < result.length; j++) {
                            if (result[j]["week"] == i) {
                              content.add(result[j]);
                            }
                          }
                          // print(content);
                          week["week" + i.toString()] = content;
                        }

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.75,
                                child: ListView.builder(
                                    itemCount: week.length,
                                    itemBuilder: (context, index) {
                                      final data = Map.from(week);
                                      print(data["week31"][0]["date"]);

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
                                                      "Week ${index + 1}",
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    // Text(
                                                    //   "Rp. ${f.format(total)}",
                                                    //   style: TextStyle(
                                                    //     fontSize: 32,
                                                    //     fontWeight:
                                                    //         FontWeight.bold,
                                                    //     color:
                                                    //         Colors.orange[700],
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${DateFormat("EE/dd-MMM").format(DateTime.now())}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.toNamed(
                                                              Routes.DAY_MONTH),
                                                      child: Text(
                                                        "VIEW MORE",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                )
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
                                  height: size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("TOTAL : ",
                                          style: TextStyle(fontSize: 22)),
                                      // Text("Rp. ${f.format(total)}",
                                      //     style: TextStyle(
                                      //         fontSize: 22,
                                      //         fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
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
