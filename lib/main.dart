import 'package:flutter/material.dart';
import 'package:spotify_clone/core/theme/app_palette.dart';
import 'package:spotify_clone/core/theme/theme.dart';
import 'package:spotify_clone/features/auth/view/sign_up_view.dart';

void main() {
  runApp(const SpofifyApp());
}

class SpofifyApp extends StatelessWidget {
  const SpofifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode.copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: SignUpView(),
    );
  }
}
