import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/views/screens/login_screen.dart';
import '../views/screens/posts_screen.dart';

class AuthController extends GetxController {
  //shared pref

  //login
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  //signup
  final nameCR = TextEditingController();
  final emailCR = TextEditingController();
  final passwordCR = TextEditingController();
  //forget
  final emailForget = TextEditingController();
  var isLoading = false.obs;
  RxBool showPassword = false.obs;

  signinWithEmail() async {
    try {
      isLoading(true);
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailCR.text, password: passwordCR.text)
          .then((value) async {
        if (user != null) {
          await firebaseFirestore
              .collection(collectionUsers)
              .doc(user!.uid)
              .set({
            'created_at': DateTime.now(),
            'id': value.user!.uid,
            'name': nameCR.text,
            'email': emailCR.text
          }).then((value) => Get.offAll(() => PostsScreen()));
        }
        isLoading(false);
      });
    } on Exception catch (e) {
      rawSnackbar(e.toString());
      isLoading(false);
    }
  }

  loginWithEmail() async {
    try {
      isLoading(true);
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailC.text, password: passwordC.text)
          .then(
            (value) => Get.offAll(() => PostsScreen()),
          );
      isLoading(false);
    } on Exception catch (e) {
      rawSnackbar(e.toString());
      isLoading(false);
    }
  }

  signinWithGoogle() async {
    try {
      isLoading(true);
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await FirebaseAuth.instance
            .signInWithCredential(authCredential)
            .then((value) async {
          await firebaseFirestore
              .collection(collectionUsers)
              .doc(user!.uid)
              .set({
            'created_at': DateTime.now(),
            'id': value.user!.uid,
            'name': value.user!.displayName,
            'email': value.user!.email,
          });
        }).then(
          (value) => Get.offAll(() => PostsScreen()),
        );
        isLoading(false);
      }
    } on Exception catch (e) {
      rawSnackbar(e.toString());
      isLoading(false);
    }
  }

  forgetPassword() async {
    try {
      await firebaseAuth
          .sendPasswordResetEmail(email: emailForget.text)
          .then((value) => Get.to(() => LoginScreen()));
    } on Exception catch (e) {
      rawSnackbar(e.toString());
    }
  }

  checkUser() {
    if (user != null) {
      Get.offAll(() => PostsScreen());
    }
  }

  rawSnackbar(String title) {
    Get.rawSnackbar(
      message: title,
      backgroundColor: AppColors.black,
    );
  }

  @override
  void onReady() {
    super.onReady();
    checkUser();
  }
}
