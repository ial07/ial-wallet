import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ial_wallet/app/components/BottomBar.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'IAL-WALLET',
            style: GoogleFonts.lora(
                fontSize: 25,
                color: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: size.height * .0,
                left: 0,
                right: 0,
                child: Container(
                  height: 170,
                  color: Colors.blue,
                )),
            Positioned(
              top: size.height * .10,
              left: 15,
              right: 15,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamExpenseToday(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data?.docs.length == 0 ||
                            snapshot.data == null) {
                          // Map<String, dynamic> data =
                          //     snapshot.data!.docs[index].data();
                          return Container(
                            width: size.width * .90,
                            height: 150,
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
                                        "Money you have spent today",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black87),
                                      ),
                                      Text(
                                        "Rp. 0",
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${DateFormat("EE/dd-MMM").format(DateTime.now())}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }

                        var dataLength = snapshot.data!.docs.length;
                        int total = 0;
                        for (int i = 0; i < dataLength; i++) {
                          Map<String, dynamic> Datas =
                              snapshot.data!.docs[i].data();
                          total += int.parse(Datas["expense"]);
                        }
                        return Container(
                          width: size.width * .90,
                          height: 150,
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
                                      "Money you have spent today",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black87),
                                    ),
                                    Text(
                                      "Rp. ${total}",
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${DateFormat("EE/dd-MMM").format(DateTime.now())}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(child: Text("Error to Get Data"));
                      }
                    }),
              ),
            ),
            Positioned(
              top: size.height * .35,
              left: 15,
              right: 15,
              bottom: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.EXPENSES),
                          child: Container(
                            width: size.width * .25,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  size: 60,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Expenses",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.INCLUSIONS),
                          child: Container(
                            width: size.width * .25,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_downward,
                                    size: 60, color: Colors.green),
                                Text(
                                  "Inclusions",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamExpenseToday(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data?.docs.length == 0 ||
                              snapshot.data == null) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text("You dont't have expenses today"),
                              ),
                            );
                          }
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.37,
                                  child: ListView.builder(
                                      reverse: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> data =
                                            snapshot.data!.docs[index].data();
                                        return Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Type :",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "${data["type"]}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: data["type"] ==
                                                                          'Daily'
                                                                      ? Colors
                                                                          .red
                                                                      : data["type"] ==
                                                                              'Frequency'
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .brown,
                                                                  fontSize: 17),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "${DateFormat("H:m").format(DateTime.parse(data["createdAt"]))}",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          "Rp. ${data["expense"]}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Center(child: Text("Error to Get Data"));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar());
  }
}
