import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/directed_controller.dart';

class DirectedView extends GetView<DirectedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sesuai request")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/ial-wallet-ae502.appspot.com/o/IMG_3489.jpg?alt=media&token=8ada45f3-9b06-49c7-aca7-d3863d21c891"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Text("EPIKK TEROSS ES",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}
