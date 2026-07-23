import 'package:flutter/material.dart';
import 'package:spotify_clone/features/auth/view/sign_up_view.dart';

void main() {
  runApp(const SpofifyApp());
}

class SpofifyApp extends StatelessWidget {
  const SpofifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpView(),
    );
  }
}
