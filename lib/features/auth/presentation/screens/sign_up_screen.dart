import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/utils/validation.dart';
import '../../../../shared/presentation/widgets/snackbar_msg.dart';
import '../../data/models/sign_up_params.dart';
import '../providers/sign_up_providers.dart';
import '../widgets/app_logo.dart';
import 'sign_in_screen.dart';
import 'verify_otp.dart';

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

  final SignUpProviders _signUpProviders = SignUpProviders();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signUpProviders,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailController,
                            decoration: InputDecoration(labelText: "Email"),
                            validator: (String? value) {
                              return Validators.validateEmail(
                                value,
                                "Enter a valid email address",
                              );
                            },
                          ),

                          SizedBox(height: 14),

                          TextFormField(
                            controller: firstNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: "First Name",
                            ),

                            validator: (String? value) {
                              return Validators.validateText(
                                value,
                                "Enter your First Name",
                              );
                            },
                          ),

                          SizedBox(height: 14),
                          TextFormField(
                            controller: lastNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(labelText: "Last Name"),
                            validator: (String? value) {
                              return Validators.validateText(
                                value,
                                "Enter your Last Name",
                              );
                            },
                          ),

                          SizedBox(height: 14),
                          TextFormField(
                            controller: phoneController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(labelText: "Phone"),
                            validator: (String? value) {
                              return Validators.validateText(
                                value,
                                "Enter your Phone Number",
                              );
                            },
                          ),

                          SizedBox(height: 14),
                          TextFormField(
                            controller: cityController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(labelText: "City"),
                            validator: (String? value) {
                              return Validators.validateText(
                                value,
                                "Enter your City",
                              );
                            },
                          ),

                          SizedBox(height: 14),

                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(labelText: "Password"),

                            validator: (String? value) {
                              return Validators.validatePassword(value);
                            },
                          ),

                          SizedBox(height: 16),

                          Consumer<SignUpProviders>(
                            builder: (context, signupProvider, child) {
                              return Visibility(
                                visible:
                                    signupProvider.signUpInProgress == false,
                                replacement: Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                child: FilledButton(
                                  onPressed: () {
                                    onTapSignUpButton();
                                  },
                                  child: Text("Register"),
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

  Future<void> onTapSignUpButton() async {
    final isValid = signupFormKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final email = emailController.text.trim();

    final isSuccess = await _signUpProviders.signUp(
      SignUpParams(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: email,
        phone: phoneController.text.trim(),
        city: cityController.text.trim(),
        password: passwordController.text,
      ),
    );

    if (!mounted) return;

    if (!isSuccess) {
      showSnackBarMessage(
        context,
        _signUpProviders.errorMessage ??
            "Registration failed. Please try again.",
      );
      return;
    }

    showSnackBarMessage(
      context,
      "An OTP has been sent to your email address. Default OTP is 1234.",
    );

    Navigator.pushNamed(
      context,
      VerifyOtp.name,
      arguments: email,
    );
  }
}
