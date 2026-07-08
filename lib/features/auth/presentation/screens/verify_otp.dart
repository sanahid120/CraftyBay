import 'package:craftybay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/features/auth/presentation/widgets/resend_otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/screens/homepage_bottom_nav_bar.dart';
import '../../../../shared/presentation/widgets/snackbar_msg.dart';
import '../providers/verify_otp_provider.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key, required this.email});

  static const String name = '/VerifyOTP';
  final String email;
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final PinInputController otpTEController = PinInputController();
  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _verifyOtpProvider,
      child: Scaffold(
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                        errorBuilder: (errorText) => Text("$errorText"),

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
                    Consumer<VerifyOtpProvider>(
                      builder: (context, _, _) {
                        return Visibility(
                          visible: _verifyOtpProvider.signUpInProgress == false,
                          replacement: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          child: FilledButton(
                            onPressed: () {
                              onSubmitButton(
                                widget.email,
                                otpTEController.text,
                              );
                            },
                            child: Text('verify'),
                          ),
                        );
                      },
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
      ),
    );
  }

  Future<void> onSubmitButton(String email, String otp) async {
    if (otp.length != 4) {
      showSnackBarMessage(context, 'Please enter a valid OTP');
    } else {
      final bool isSuccess = await _verifyOtpProvider.verifyOTP(email, otp);
      if(!mounted) return;
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomepageBottomNavBar.name,
          (_) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_verifyOtpProvider.errorMessage!)),
        );
      }
    }
  }

  void onSignInButton(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void onTapResendButton(String s) {
    showSnackBarMessage(context, s);
  }
}
