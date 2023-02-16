import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/controllers/auth_controller.dart';
import 'package:share_post/views/components/app_button.dart';
import 'package:share_post/views/components/app_textfield.dart';


class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  var authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            Image.asset(
              'assets/images/rs_logo.png',
              height: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Please enter your email to get link for new password',
              textAlign: TextAlign.center,
              style:
                  AppTextStyle.regularBlack16.copyWith(color: AppColors.grey),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(
                    width: width,
                    controller: authController.emailForget,
                    leading: Icons.account_box,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                    hint: 'Enter your email',
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    width: width * 0.6,
                    height: 65,
                    text: 'Send',
                    onTap: () async {
                      await authController.forgetPassword();
                      authController.rawSnackbar('Email sent check your email');
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Know your password? ',
                        style: AppTextStyle.regularBlack14
                            .copyWith(color: AppColors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(() => Login());
                        },
                        child: Text(
                          'Login',
                          style: AppTextStyle.boldBlack14
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
