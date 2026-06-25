import 'package:craftybay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:craftybay/features/auth/presentation/screens/verify_otp.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = "/SignUpScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();

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
                  "Join With Us",
                  style: TextTheme.of(
                    context,
                  ).titleLarge?.copyWith(fontSize: 36),
                ),

                Text(
                  "Get started with your details",
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 26),

                Form(
                  key: signupFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your Email';
                            } else if (EmailValidator.validate(value!) ==
                                false) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 14),

                        TextFormField(
                          controller: firstNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(labelText: "First Name"),

                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your First Name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 14),
                        TextFormField(
                          controller: lastNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(labelText: "Last Name"),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Last Name';
                            } else if (value!.length < 2) {
                              return 'your name should contain least of 2 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 14),
                        TextFormField(
                          controller: phoneController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(labelText: "Phone"),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Phone Number';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 14),
                        TextFormField(
                          controller: cityController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(labelText: "City"),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your City name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 14),

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

                        FilledButton(onPressed: () {onTapSignUpButton(emailController.text.trim());}, child: Text("Register")),

                        SizedBox(height: 16),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),

                            text: 'Already have an account? ',
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                text: 'SignIn',
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
      Navigator.pushReplacementNamed(context, SignInScreen.name);

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    cityController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void onTapSignUpButton(String email) {
    Navigator.pushNamed(context, VerifyOtp.name);
  }
}
