import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viachatapp/models/chat_model.dart';
import 'package:viachatapp/providers/chats_provider.dart';

import 'package:viachatapp/widgets/toggle_button.dart';

enum InputMode {
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceField();
}

class _TextAndVoiceField extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  final AIHandler _openAI = AIHandler();
  //final VoiceHandler voiceHandler = VoiceHandler();
  var _isReplying = false;
  //var _isListening = false;

  @override
  void dispose() {
    _messageController.dispose();
    // _openAI.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value) {
              value.isNotEmpty
                  ? setInputMode(InputMode.text)
                  : setInputMode(InputMode.voice);
            },
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 06,
        ),
        ToggleButton(
          //isListening: _isListening,
          isReplying: _isReplying,
          inputMode: _inputMode,
          sendTextMessage: () {
            final message = _messageController.text;
            _messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        )
      ],
    );
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() {}

  void sendTextMessage(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.voice);
    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addToChatList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void setReplyingState(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void addToChatList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
    ));
  }
}
