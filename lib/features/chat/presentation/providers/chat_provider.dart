import 'dart:collection';

import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/chat/service/model_caller.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatModel> _messages = [
    ChatModel(
      role: 'assistant',
      text: 'Hello, I am your personal assistant. How can I help you?',
      time: DateTime.now(),
    ),
  ];

  bool _sendMessageInProgress = false;
  String? _errorMessage;

  UnmodifiableListView<ChatModel> get messages =>
      UnmodifiableListView(_messages);

  bool get sendMessageInProgress => _sendMessageInProgress;

  String? get errorMessage => _errorMessage;

  void addMessage(ChatModel message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<bool> sendMessage(String input) async {
    final String message = input.trim();

    if (message.isEmpty || _sendMessageInProgress) {
      return false;
    }

    final ChatModel userMessage = ChatModel(
      role: 'user',
      text: message,
      time: DateTime.now(),
    );

    _messages.add(userMessage);
    _sendMessageInProgress = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final NetworkResponse response = await getModelCaller().postRequest(
        Urls.openRouterUrl,
        body: {
          'model': 'openai/gpt-4o',
          'messages': _messages.map((message) => message.toApiJson()).toList(),
          'temperature': 0,
          'max_tokens': 50,
        },
      );

      if (!response.isSuccess) {
        _errorMessage =
            response.errorMessage ?? 'Failed to generate a response.';

        return false;
      }

      if (response.body is! Map<String, dynamic>) {
        _errorMessage = 'Invalid response format.';
        return false;
      }

      final ChatModel assistantMessage = ChatModel.fromJson(
        response.body as Map<String, dynamic>,
      );

      if (assistantMessage.text.trim().isEmpty) {
        _errorMessage = 'The assistant returned an empty response.';
        return false;
      }

      _messages.add(assistantMessage);
      return true;
    } catch (error) {
      _errorMessage = 'Something went wrong: $error';
      return false;
    } finally {
      _sendMessageInProgress = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _messages
      ..clear()
      ..add(
        ChatModel(
          role: 'assistant',
          text: 'Hello, I am your personal assistant. How can I help you?',
          time: DateTime.now(),
        ),
      );

    _errorMessage = null;
    notifyListeners();
  }
}
