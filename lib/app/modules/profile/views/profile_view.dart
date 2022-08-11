import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/components/BottomBar.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            user["image"] != null && user["image"] != ""
                                ? user["image"]
                                : "https://ui-avatars.com/api/?name=${user["name"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${user["email"].toString().toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () =>
                        Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                    leading: Icon(Icons.person),
                    title: Text("Update profile"),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                    leading: Icon(Icons.vpn_key),
                    title: Text("Update password"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.DIRECTED);
                    },
                    leading: Icon(Icons.baby_changing_station_rounded),
                    title: Text("DIRECTED BY"),
                  ),
                  ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  ),
                ],
              );
            } else {
              return Center(child: Text("Cannot be load the data"));
            }
          }),
      bottomNavigationBar: BottomBar(),
    );
  }
}
