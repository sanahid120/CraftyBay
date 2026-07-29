import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/chat/presentation/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chat_model.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/date_header.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String name = '/chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController =
  TextEditingController();

  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage() async {
    final String message = _messageController.text.trim();

    if (message.isEmpty) return;

    final ChatProvider provider = context.read<ChatProvider>();

    if (provider.sendMessageInProgress) return;

    _messageController.clear();
    FocusScope.of(context).unfocus();

    // sendMessage adds the user's message before its first await.
    final Future<bool> request = provider.sendMessage(message);

    _scrollToBottom();

    final bool isSuccess = await request;

    if (!mounted) return;

    _scrollToBottom();

    if (!isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ??
                'Failed to send the message.',
          ),
        ),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _clearChat() async {
    final bool? shouldClear = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Clear conversation?'),
          content: const Text(
            'All messages in this conversation will be removed.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            SizedBox(
              width: 100,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(dialogContext, true);
                },
                child: const Text('Clear'),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || shouldClear != true) return;

    context.read<ChatProvider>().clearMessages();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildMessageArea()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 72,
      backgroundColor: AppColors.themeColor,
      elevation: 1,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      titleSpacing: 0,
      title: const Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.support_agent,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 1,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CraftyBay Assistant',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [

        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'clear') {
              _clearChat();
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline,color: Colors.red,),
                    SizedBox(width: 10),
                    Text('Clear chat'),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget _buildMessageArea() {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        final List<ChatModel> messages = provider.messages;

        if (messages.isEmpty) {
          return const Center(
            child: Text('Start a new conversation'),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount:
          messages.length +
              (provider.sendMessageInProgress ? 1 : 0) +
              1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const ChatDateHeader();
            }

            final int messageIndex = index - 1;

            if (messageIndex == messages.length &&
                provider.sendMessageInProgress) {
              return const TypingIndicator();
            }

            final ChatModel message = messages[messageIndex];

            return ChatMessageBubble(message: message);
          },
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE1E5E2)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              tooltip: 'Attach file',
              onPressed: () {
                // Add image_picker or file_picker here.
              },
              color: AppColors.themeColor,
              icon: const Icon(Icons.add_circle_outline),
            ),
            Expanded(
              child: TextField(
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black
                ),
                controller: _messageController,
                minLines: 1,
                maxLines: 5,
                textCapitalization:
                TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  filled: true,

                  fillColor: const Color(0xFFF0F3F1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // Add an emoji picker here.
                    },
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) {
                  _sendMessage();
                },
              ),
            ),
            const SizedBox(width: 8),
            Consumer<ChatProvider>(
              builder: (context, provider, child) {
                return Material(
                  color: provider.sendMessageInProgress
                      ? Colors.grey
                      : AppColors.themeColor,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: provider.sendMessageInProgress
                        ? null
                        : _sendMessage,
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: provider.sendMessageInProgress
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}