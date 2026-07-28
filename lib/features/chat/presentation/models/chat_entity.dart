class ChatEntity {
  final String role;
  final String text;
  final DateTime time;

  const ChatEntity({
    required this.role,
    required this.text,
    required this.time,
  });

  bool get isUser => role == 'user';

  bool get isAssistant => role == 'assistant';
}