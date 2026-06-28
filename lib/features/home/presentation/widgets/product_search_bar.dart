
import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withAlpha(30),
          hintText: "Search",
          prefixIcon: Icon(Icons.search),

          border:  OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),

          )
      ),
    );
  }
}


