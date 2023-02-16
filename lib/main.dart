import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/views/screens/auth/login_screen.dart';

import 'views/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppColors.primarySwatch,
        ),
        home: user == null ? LoginScreen() : const Dashboard());
  }
}
