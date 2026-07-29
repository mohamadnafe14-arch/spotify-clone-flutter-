import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/functions/show_snack_bar.dart';
import 'package:spotify_clone/features/auth/view/sign_up_view.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_button.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_text_form_field.dart';
import 'package:spotify_clone/features/auth/view/widgets/custom_text_button.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:spotify_clone/features/home/views/home_view.dart';

class SignInBody extends ConsumerStatefulWidget {
  const SignInBody({super.key});

  @override
  ConsumerState<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends ConsumerState<SignInBody> {
  late GlobalKey<FormState> formKey;
  String? email, password;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
        data: (data) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (_) => false,
          );
        },
        error: (error, stackTrace) {
          showSnackBar(error.toString(), context);
        },
        loading: () {},
      );
    });
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
                    ref
                        .read(authViewmodelProvider.notifier)
                        .login(email: email!, password: password!);
                  }
                },
                text: 'Sign In',
                isLoading: ref.watch(authViewmodelProvider)?.isLoading ?? false,
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
