
import 'package:craftybay/app/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/provider/homepage_main_nav_provider.dart';
import '../widgets/cart_item.dart';
import '../widgets/total_price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) {
        onBackButtonPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.cart),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              onBackButtonPressed(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CartItem();
                },
              ),
            ),
            TotalPriceAndCheckoutSection(totalPrice: 120, onTapCheckout: () {}),
          ],
        ),
      ),
    );
  }

  void onBackButtonPressed(BuildContext context) {
    context.read<HomepageMainNavProvider>().moveToHomepage();
  }
}
