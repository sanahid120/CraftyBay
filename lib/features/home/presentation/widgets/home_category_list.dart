
import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/widgets/category_card.dart';
import '../../../category/presentaion/providers/category_list_provider.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if(categoryListProvider.initialLoadInProgress == true){
            return Center(child: CircularProgressIndicator());

          }
          return ListView.separated(
            scrollDirection: .horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => CategoryCard(categoryListProvider.categories[index]),
            separatorBuilder: (_, _) => SizedBox(width: 8),
            itemCount: getCategoryLength(categoryListProvider.categories.length),
          );
        }
      ),
    );
  }
  int getCategoryLength(int length){
    return length >15 ? 15 : length;
  }
}
