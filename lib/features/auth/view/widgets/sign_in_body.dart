import 'package:flutter/material.dart';
import 'package:spotify_clone/features/auth/view/sign_up_view.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_button.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_text_form_field.dart';
import 'package:spotify_clone/features/auth/view/widgets/custom_text_button.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  late GlobalKey<FormState> formKey;
  String? email, password;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                'Sign In',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              AuthTextFormField(
                hintText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  if (value.contains('@') == false) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              const SizedBox(height: 20),
              AuthTextFormField(
                hintText: 'Password',
                obscureText: true,
                onSaved: (value) => password = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                },
                text: 'Sign In',
                isLoading: false,
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                firstText: "Don't have an account?",
                btnText: "Sign Up",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUpView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
