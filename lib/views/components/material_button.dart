import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
     this.height = 46,
     this.width = 113,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color color;
  final Text text;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        minWidth: width,
        height: height,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: text);
  }
}
