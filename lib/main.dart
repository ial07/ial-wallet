import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ial_wallet/app/components/Theme.dart';
import 'package:ial_wallet/app/controllers/main_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pageC = Get.put(MainController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
            theme: _lightTheme,
            // darkTheme: _darkTheme,
            themeMode: ThemeMode.system,
          );
        }),
  );
}

// ThemeData _darkTheme = ThemeData(
//     textTheme: GoogleFonts.loraTextTheme(),
//     accentColor: Colors.red,
//     brightness: Brightness.dark,
//     primaryColor: Colors.amber,
//     buttonTheme: ButtonThemeData(
//       buttonColor: Colors.amber,
//       disabledColor: Colors.grey,
//     ));

ThemeData _lightTheme = ThemeData(
    textTheme: GoogleFonts.loraTextTheme(),
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ));
