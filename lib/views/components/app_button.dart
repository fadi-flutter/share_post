import 'package:flutter/material.dart';

import '../../const/app_colors.dart';
import '../../const/app_textstyle.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.width,
    this.height,
    this.text,
    this.onTap,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          text ?? '',
          style: AppTextStyle.regularBlack18.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
