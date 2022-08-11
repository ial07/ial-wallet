import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class BottomBar extends StatelessWidget {
  final pageC = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.textIn,
      items: [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.list_alt, title: 'Mutation'),
        TabItem(icon: Icons.people, title: 'Profile'),
      ],
      initialActiveIndex: pageC.pageIndex.value, //optional, default as 0
      onTap: (int i) => pageC.changePage(i),
    );
  }
}
