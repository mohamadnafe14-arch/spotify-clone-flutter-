import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.firstText,
    required this.btnText,
    required this.onTap,
  });
  final String firstText, btnText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          firstText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            " $btnText",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
