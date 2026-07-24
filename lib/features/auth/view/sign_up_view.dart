import 'package:flutter/material.dart';
import 'package:spotify_clone/features/auth/view/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: const SignUpBody()));
  }
}
