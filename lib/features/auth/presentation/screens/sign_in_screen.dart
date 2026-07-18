import 'package:craftybay/features/auth/presentation/screens/homepage.dart';
import 'package:craftybay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:craftybay/features/auth/presentation/screens/verify_otp.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/shared/presentation/screens/homepage_bottom_nav_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/widgets/snackbar_msg.dart';
import '../providers/sign_in_provider.dart';

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
  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signInProvider,
      child: Scaffold(
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
                    style: TextTheme.of(
                      context,
                    ).titleLarge?.copyWith(fontSize: 36),
                  ),

                  Text(
                    "Please Enter Your Email and Password to Enter",
                    style: TextTheme.of(
                      context,
                    ).bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 26),

                  Form(
                    key: signInFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailController,
                            decoration: InputDecoration(labelText: "Email"),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your Email';
                              } else if (!EmailValidator.validate(value!)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),

                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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

                          Consumer<SignInProvider>(
                            builder: (context, _, _) {
                              return Visibility(
                                visible:
                                    _signInProvider.signInProgress == false,
                                replacement: Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                child: FilledButton(
                                  onPressed: () {
                                    onLoginButton(context);
                                  },
                                  child: Text("login"),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 16),

                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),

                              text: 'Don\'t you have an account? ',
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  text: 'SignUp',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      onSignUpButton(context);
                                    },
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onForgotPasswordPress(context);
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationThickness: 1.5,
                              ),
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
      ),
    );
  }

  void onSignUpButton(BuildContext context) =>
      Navigator.pushReplacementNamed(context, SignUpScreen.name);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onForgotPasswordPress(BuildContext context) {
    Navigator.pushReplacementNamed(context, VerifyOtp.name);
  }

  Future<void> onLoginButton(BuildContext context) async {
    if (signInFormKey.currentState!.validate()) {
      bool isSuccess = await _signInProvider.signIn(
        emailController.text.trim(),
        passwordController.text,
      );
      if(!mounted) return;

      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomepageBottomNavBar.name,
          (_) => false,
        );
      } else {
        showSnackBarMessage(context, _signInProvider.errorMessage?? "Something went wrong! Please try again");
      }
    }
  }
}
