import 'dart:io';

import 'package:craftybay/app/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});
  static const String name = "/AddNewProduct";

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final picker = ImagePicker();
  List<XFile>? images;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Save", child: Text("Save")),
                PopupMenuItem(value: "Cancel", child: Text("Cancel")),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                Image.asset(AssetPaths.noImagePng, height: 100, width: 100),
                Text(
                  "Upload Product Images",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                Text(
                  "JPG, PNG . Up to 5 Images",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(
                  width: 150,
                  child: FilledButton(
                    onPressed: () {
                      onPressedImagePicker(context);
                    },
                    child: Text("Choose Images"),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          const SizedBox(height: 20),

          // FIX: Add a conditional check here
          if (images != null && images!.isNotEmpty)
            SizedBox(
              height: 400,
              width:500,
              // Give it a fixed height to avoid layout errors
              child: Center(child: Image.file(File(images![0].path), fit: BoxFit.contain,cacheHeight: 400,cacheWidth: 500,)),
            )
          else
            const Text("No image selected"), // Placeholder when list is empty
        ],
      ),
    );
  }

  void onPressedImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.image),
            title: Text("Gallery"),
            onTap: () async {
              final List<XFile> pickedImages = await picker.pickMultiImage(
                limit: 4,
              );
              if (!mounted) return;
              if (pickedImages.isNotEmpty) {
                setState(() {
                  images = pickedImages;
                });
              }

              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("Camera"),
            onTap: () async {
              final XFile? pickedImage = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (!mounted) return;
              if(pickedImage != null){
                images = [pickedImage];
              }
              else{
                images = [];
              }
              setState(() {

              });
            },
          ),
        ],
      ),
    );
  }
}
