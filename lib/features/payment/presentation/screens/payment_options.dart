import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});
  static const String name = "/PaymentOptions";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Options"),
        centerTitle: true,
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

     body: SingleChildScrollView(
       child: Column(
         children: [

         ],
       ),
     ),
    );
  }
}
