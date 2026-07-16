class CartModel {
  final String product;
  final String color;
  final String size;
  final int quantity;

  CartModel({
    required this.product,
    required this.color,
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'product': product,
      'quantity': quantity,
    };
    if (color.isNotEmpty) {
      data['color'] = color;
    }
    if (size.isNotEmpty) {
      data['size'] = size;
    }

    return data;
  }
}
