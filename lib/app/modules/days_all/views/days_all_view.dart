import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/days_all_controller.dart';

class DaysAllView extends StatelessWidget {
  final controller = Get.put(DaysAllController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamDaysMonthAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
                  return Center(
                    child: Text("You dont't have expenses"),
                  );
                }
                List<Map<String, dynamic>> result = [];
                for (var i = 0; i < snapshot.data!.docs.length; i++) {
                  Map<String, dynamic> data = {};
                  DateTime todayDate = DateTime.parse(snapshot.data!.docs[i]
                      .data()["date"]
                      .split('-')
                      .reversed
                      .join());
                  data["date"] = todayDate;
                  data["createdAt"] =
                      snapshot.data!.docs[i].data()["createdAt"];
                  data["uid"] = snapshot.data!.docs[i].data()["uid"];
                  data["week"] = snapshot.data!.docs[i].data()["week"];
                  data["month"] = snapshot.data!.docs[i].data()["month"];
                  data["year"] = snapshot.data!.docs[i].data()["year"];
                  data["type"] = snapshot.data!.docs[i].data()["type"];
                  data["expense"] = snapshot.data!.docs[i].data()["expense"];
                  data["desc"] = snapshot.data!.docs[i].data()["desc"];
                  result.add(data);
                }
                result.sort((a, b) => b["date"].compareTo(a["date"]));

                var dataLength = snapshot.data!.docs.length;

                var f = NumberFormat.decimalPattern();
                int total = 0;
                for (int i = 0; i < dataLength; i++) {
                  Map<String, dynamic> Datas = snapshot.data!.docs[i].data();
                  total += int.parse(Datas["expense"]);
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.75,
                        child: ListView.builder(
                            reverse: true,
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = result[index];

                              return InkWell(
                                onTap: () => Get.toNamed(Routes.UPDATE_EXSPENSE,
                                    arguments: data),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 70,
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Type :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "${data["type"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: data["type"] ==
                                                                  'Daily'
                                                              ? Colors.red
                                                              : data["type"] ==
                                                                      'Frequency'
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .brown,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${DateFormat("dd-MM-yyyy").format(data['date']).toString()}",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Rp. ${data["expense"]}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${data["desc"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
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
                          height: size.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("TOTAL : ", style: TextStyle(fontSize: 22)),
                              Text("Rp. ${f.format(total)}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
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
      ],
    );
  }
}
