import 'package:craftybay/features/chat/presentation/models/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.role,
    required super.text,
    required super.time,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> choices =
        json['choices'] as List<dynamic>? ?? [];

    if (choices.isEmpty) {
      throw const FormatException(
        'The API response does not contain any choices.',
      );
    }

    final Map<String, dynamic> firstChoice =
    choices.first as Map<String, dynamic>;

    final Map<String, dynamic> message =
        firstChoice['message'] as Map<String, dynamic>? ?? {};

    final int? created = json['created'] as int?;

    return ChatModel(
      role: message['role']?.toString() ?? 'assistant',
      text: message['content']?.toString() ?? '',
      time: created != null
          ? DateTime.fromMillisecondsSinceEpoch(
        created * 1000,
        isUtc: true,
      ).toLocal()
          : DateTime.now(),
    );
  }

  /// Used when sending messages to the chat API.
  Map<String, dynamic> toApiJson() {
    return {
      'role': role,
      'content': text,
    };
  }

  /// Used if you want to save the message locally.
  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': text,
      'time': time.toIso8601String(),
    };
  }

  /// Used when loading locally saved messages.
  factory ChatModel.fromLocalJson(Map<String, dynamic> json) {
    return ChatModel(
      role: json['role']?.toString() ?? 'assistant',
      text: json['content']?.toString() ?? '',
      time:
      DateTime.tryParse(json['time']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}