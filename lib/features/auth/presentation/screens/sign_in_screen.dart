import 'package:craftybay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = "/SignInScreen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppLogo(),

                SizedBox(height: 20),

                Text(
                  "Welcome Back",
                  style: TextTheme
                      .of(
                    context,
                  )
                      .titleLarge
                      ?.copyWith(fontSize: 36),
                ),

                Text(
                  "Please Enter Your Email and Password to Enter",
                  style: TextTheme
                      .of(
                    context,
                  )
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 26),

                Form(
                  key: signInFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          validator: (String? value) {
                            if (value
                                ?.trim()
                                .isEmpty ?? true) {
                              return 'Enter your Email';
                            } else if (EmailValidator.validate(value!) ==
                                false) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),

                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),

                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Password';
                            }
                            if (value!.length < 6) {
                              return 'Your Password must be least of 6 character';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),

                        FilledButton(onPressed: () {}, child: Text("login")),

                        SizedBox(height: 16),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),

                            text: 'Don\'t you have an account? ',
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                                text: 'SignUp',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    onSignInButton(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSignInButton(BuildContext context) =>
      Navigator.pushReplacementNamed(context, SignUpScreen.name);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }

}
