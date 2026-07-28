import 'package:flutter/material.dart';

class ChatDateHeader extends StatelessWidget {
  const ChatDateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE2E7E4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Today',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}