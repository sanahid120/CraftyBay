import 'package:craftybay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/features/auth/presentation/widgets/resend_otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  static const String name = '/VerifyOTP';

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final PinInputController otpTEController = PinInputController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  SizedBox(height: 50),
                  AppLogo(),
                  Text(
                    'Enter your OTP',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
              
                  Text(
                    'Enter the 4 digit pin sent to your email address',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
              
                  Center(
                    child: MaterialPinField(
                      pinController: otpTEController,
                      length: 4,
                      keyboardType: TextInputType.number,
                      obscureText: false,



                      // onCompleted: (pin) => print('PIN: $pin'),
                      // onChanged: (value) => print('Changed: $value'),
                      theme: MaterialPinTheme(
                        spacing: 12,
                        disabledColor: Colors.white,
                        borderWidth: 1.5,
                        focusedFillColor: Colors.white,
                        shape: MaterialPinShape.outlined,
                        cellSize: Size(45, 45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  FilledButton(
                    onPressed: () {
                      onSubmitButton();
                    },
                    child: Text('verify'),
                  ),
                  SizedBox(height: 24),
                  ResendOtpSection(),
                  SizedBox(height: 14),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            text: 'Already have an account? ',
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmitButton() {}

  void onSignInButton(BuildContext context) {Navigator.pushReplacementNamed(context, SignInScreen.name);}
}
