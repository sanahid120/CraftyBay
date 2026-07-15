import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:craftybay/features/products/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/widgets/product_card.dart';
import '../../../products/presentation/providers/product_list_provider.dart';


class HorizontalProductListView extends StatefulWidget {
  const HorizontalProductListView({
    super.key, required this.category,
  });
  final CategoryModel category;

  @override
  State<HorizontalProductListView> createState() => _HorizontalProductListViewState();
}
class _HorizontalProductListViewState extends State<HorizontalProductListView> {
  final ProductListProvider _productListProvider = ProductListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListProvider.getProducts(widget.category.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: SizedBox(
        height: 340,
        child: Consumer<ProductListProvider>(

          builder: (context, provider, _) {
            if (provider.initialLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.products.length,
              itemBuilder: (context, index) => SizedBox(
                width: 240,

                child: ProductCard(
                  provider.products[index],
                ),

              ),
            );
          },
        ),
      ),
    );
  }
}