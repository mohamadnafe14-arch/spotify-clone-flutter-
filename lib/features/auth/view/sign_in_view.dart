import 'package:flutter/material.dart';
import 'package:spotify_clone/features/auth/view/widgets/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: SignInBody()));
  }
}
