import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/features/auth/view/sign_in_view.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_button.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_text_form_field.dart';
import 'package:spotify_clone/features/auth/view/widgets/custom_text_button.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';

class SignUpBody extends ConsumerStatefulWidget {
  const SignUpBody({super.key});
  @override
  ConsumerState<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends ConsumerState<SignUpBody> {
  late GlobalKey<FormState> formKey;
  String? name, email, password;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();

    ref.listenManual(authViewmodelProvider, (previous, next) {
      next?.when(
        data: (data) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("${data.name} logged in")));
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
        loading: () {},
      );
    });
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
                'Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              AuthTextFormField(
                hintText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
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
                    ref
                        .read(authViewmodelProvider.notifier)
                        .signUp(
                          email: email!,
                          password: password!,
                          name: name!,
                        );
                  }
                },
                text: 'Sign Up',
                isLoading: ref.watch(authViewmodelProvider)?.isLoading ?? false,
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                firstText: "Already have an account?",
                btnText: "Sign In",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignInView()),
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
