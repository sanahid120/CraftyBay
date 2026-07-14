class ProductModel {
  final String id;
  final String title;
  final int currentPrice;
  final String description;
  final int productQuantity;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;



  ProductModel({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.description,
    required this.productQuantity,
    required this.photos,
    this.colors = const [],
    this.sizes = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      productQuantity: json['quantity'],
      currentPrice: json['current_price'],
      photos: List<String>.from(json['photos']),
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json['sizes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'current_price': currentPrice,
      'photos': photos,
      'description': description,
      'quantity': productQuantity,
      'colors': colors,
      'sizes': sizes,
    };
  }
}

/*

{
                "_id": "681372b57aff1010848eea4c",
                "title": "Mac mini m4",
                "brand": {
                    "_id": "6799d84bceaaf5d3413a0989",
                    "title": "Apple",
                    "slug": "apple",
                    "icon": "https://cdn.ostad.app/public/upload/2023-06-22T06-40-41.054Z-code-box-line.png"
                },
                "categories": [
                    {
                        "_id": "6812518cea40bfc6edc67356",
                        "title": "Apply",
                        "slug": "apply",
                        "icon": "https://cdn-icons-png.flaticon.com/256/0/747.png"
                    }
                ],
                "slug": "macminim4",
                "meta_description": null,
                "description": "Mac mini m4 16GB Ram",
                "photos": [
                    "https://mcsolution.com.bd/wp-content/uploads/2024/10/mac-mini-m4-2024-price-in-Bangladesh-MC-Solution-BD-2.webp"
                ],
                "colors": [],
                "sizes": [],
                "tags": [],
                "regular_price": null,
                "current_price": 70000,
                "quantity": 1,
                "createdAt": "2025-05-01T13:10:13.522Z",
                "updatedAt": "2025-05-01T13:10:13.522Z"
            },
 */
