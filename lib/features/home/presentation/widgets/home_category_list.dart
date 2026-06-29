
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/category_card.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: .horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => CategoryCard(),
        separatorBuilder: (_, _) => SizedBox(width: 8),
        itemCount: 10,
      ),
    );
  }
}
