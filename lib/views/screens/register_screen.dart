import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/controllers/auth_controller.dart';
import '../../const/app_colors.dart';
import '../../const/app_textstyle.dart';
import '../components/app_button.dart';
import '../components/app_textfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetX<AuthController>(builder: (controller) {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
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
                      'Please enter your email address\nand create password',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regularBlack16
                          .copyWith(color: AppColors.grey),
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
                            controller: controller.nameCR,
                            leading: Icons.account_box,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            hint: 'Enter your full name',
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          AppTextField(
                            width: width,
                            controller: controller.emailCR,
                            leading: Icons.email,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            hint: 'Enter your email',
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          AppTextField(
                            width: width,
                            controller: controller.passwordCR,
                            onTrailingTap: () {
                              controller.showPassword.value
                                  ? controller.showPassword(false)
                                  : controller.showPassword(true);
                            },
                            obsecure:
                                controller.showPassword.value ? false : true,
                            leading: Icons.lock,
                            trailing: controller.showPassword.value
                                ? Icons.remove_red_eye_sharp
                                : Icons.remove_red_eye,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.done,
                            hint: 'Enter your password',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 22,
                          ),
                          AppButton(
                            width: width * 0.6,
                            height: 65,
                            text: 'Sign Up',
                            onTap: () async {
                              await controller.signinWithEmail();
                              controller.rawSnackbar('Signed In');
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: AppTextStyle.regularBlack14
                                    .copyWith(color: AppColors.grey),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Login',
                                  style: AppTextStyle.boldBlack14
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'Sign in with',
                                  style: AppTextStyle.regularBlack14
                                      .copyWith(color: AppColors.grey),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.signinWithGoogle();
                              controller.rawSnackbar('Signed In');
                            },
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              margin: const EdgeInsets.only(bottom: 20),
                              width: width,
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 36,
                                  ),
                                  Text(
                                    'Google',
                                    style: AppTextStyle.mediumBlack18,
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
