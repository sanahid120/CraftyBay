import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/payment/methds/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../products/data/model/product_model.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key,required this.productDetails});
  static const String name = "/PaymentOptions";

  final ProductModel productDetails;


  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String? selected;
  List<Map> paymentOptions = [
    {
      'name': 'Bkash',
      'icon': 'https://www.logo.wine/a/logo/BKash/BKash-Icon-Logo.wine.svg',
    },
    {
      'name': 'Nagad',
      'icon': 'https://www.logo.wine/a/logo/Nagad/Nagad-Logo.wine.svg',
    },
  ];
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

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          mainAxisAlignment: .center,

          children: [
            Expanded(
              child: ListView.separated(
                itemCount: paymentOptions.length,
                shrinkWrap: true,
                primary: false,

                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selected = paymentOptions[index]['name'].toLowerCase();
                      setState(() {});
                    },

                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color:
                              selected ==
                                  paymentOptions[index]['name'].toLowerCase()
                              ? AppColors.themeColor
                              : Colors.grey.shade300,
                          width:
                              selected ==
                                  paymentOptions[index]['name'].toLowerCase()
                              ? 2
                              : 1,
                        ),
                      ),

                      selected:
                          selected ==
                          paymentOptions[index]['name'].toLowerCase(),

                      leading: SvgPicture.network(
                        paymentOptions[index]['icon'],
                        height: 50,
                        width: 50,
                      ),
                      title: Text(paymentOptions[index]['name']),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: FilledButton(
                onPressed: () {
                  if (selected != null) {
                    onTapPayment(selected!, context, widget.productDetails.currentPrice.toDouble());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a payment method")),
                    );
                  }
                },
                child: Text("Continue to payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
