import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/widgets/product_card.dart';
import '../providers/product_list_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;
  static const String name = "/ProductListScreen";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final ProductListProvider _productListProvider = ProductListProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productListProvider.getProducts(widget.category.id);
      _scrollController.addListener(loadMoreProducts());
    });
  }

  VoidCallback loadMoreProducts() {
    return () {
      if (_scrollController.position.extentAfter < 200) {
        _productListProvider.getProducts(widget.category.id);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _productListProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.title),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),

        body: Consumer<ProductListProvider>(
          builder: (context, _, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Visibility(
                    visible:
                        _productListProvider.initialLoadInProgress == false,
                    replacement: LinearProgressIndicator(),
                    child: Expanded(
                      child: _productListProvider.products.isEmpty
                          ? Center(
                                child: Text(
                                  'No Product Found!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.themeColor,
                                  ),
                                ),
                              )

                          : GridView.builder(
                              itemCount: _productListProvider.products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: .65,
                                  ),
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  _productListProvider.products[index],
                                );
                              },
                            ),
                    ),
                  ),
                  if (_productListProvider.loadMoreInProgress)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
