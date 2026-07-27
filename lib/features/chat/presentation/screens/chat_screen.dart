import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String name = "/chatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatScreen"),
        centerTitle: true,
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: SingleChildScrollView(child: Column(children: [
        Center(child: Icon(Icons.chat_outlined,size: 100,color: AppColors.themeColor,),)
      ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
