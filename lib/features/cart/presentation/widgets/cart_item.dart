import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_paths.dart';
import '../../../../app/constants.dart';
import '../../../../shared/presentation/widgets/inc_dec_button.dart';


class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.themeColor.withAlpha(50),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(

          children: [
            Container(
              width: 100,
              height: 100,

              padding: EdgeInsets.all(4),
              child: Image.asset(AssetPaths.shoeImage),
            ),

            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "this is New year special giftdddddsssssssssssdhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                              style: TextTheme.of(context).titleMedium?.copyWith( fontSize: 18),overflow: TextOverflow.ellipsis,maxLines: 2,
                            ),
                            Text(
                              "Color: Red Size: XL",
                              style: TextTheme.of(
                                context,
                              ).titleMedium?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      FittedBox(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text("${Constants.takaSing}100",style: TextTheme.of(context).titleMedium?.copyWith(color: AppColors.themeColor),),
                        IncDecButton(onChange: (int quantity) {})
                      ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
