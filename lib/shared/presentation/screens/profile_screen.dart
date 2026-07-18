
import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = "/ProfileScreen";


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),


    ),
      body: Center(
        child: Text("Profile Screen is Yet To Complete!",style: TextStyle(
          color: AppColors.themeColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
      ),

    );



  }
}
