import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double width;
  final double height;
  final Color textColor;
  final VoidCallback? onPress;

  const ButtonWidget(
      {required this.text,
      required this.backgroundColor,
      required this.height,
      required this.width,
      required this.textColor,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              side: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(30))),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          foregroundColor: WidgetStatePropertyAll(textColor),
          elevation: WidgetStatePropertyAll(1),
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.transparent),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
