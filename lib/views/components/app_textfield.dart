import 'package:flutter/material.dart';
import '../../const/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.width,
    this.hint,
    required this.controller,
    this.inputType,
    this.inputAction,
    this.leading,
    this.trailing,
    this.obsecure,
    this.onTrailingTap,
    this.height,
  }) : super(key: key);

  final double width;
  final double? height;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final IconData? leading;
  final IconData? trailing;
  final Function()? onTrailingTap;
  final bool? obsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              leading,
              color: AppColors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obsecure ?? false,
              style: const TextStyle(fontSize: 16, color: AppColors.primary),
              textInputAction: inputAction,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 16, color: AppColors.grey),
                contentPadding: const EdgeInsets.only(bottom: 8, top: 2),
              ),
            ),
          ),
          trailing != null
              ? GestureDetector(
                  onTap: onTrailingTap,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      trailing,
                      color: AppColors.grey,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
