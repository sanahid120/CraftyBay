import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/product_card.dart';


class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        scrollDirection: .horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => ProductCard(),
      ),
    );
  }
}
