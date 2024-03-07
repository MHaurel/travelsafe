import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/widgets/message_widget.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key, required this.messages});

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) => MessageWidget(message: messages[index]),
    );
  }
}
