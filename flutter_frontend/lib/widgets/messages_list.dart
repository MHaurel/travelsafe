import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/widgets/message_widget.dart';

class MessagesList extends StatelessWidget {
  const MessagesList(
      {super.key, required this.messages, required this.countryIndex});

  final List<Message> messages;
  final int countryIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      // child: Text(messages.length.toString()),
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) => MessageWidget(
          message: messages[index],
          countryIndex: countryIndex,
        ),
      ),
    );
  }
}
