import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/reaction_list.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.message});

  final Message message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  void _onMessageAnswer() {
    // TODO: code the function
    print("Asking to answer message");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
          Stack(alignment: Alignment.bottomRight, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF575757),
                            child: Icon(
                              Icons.person_2,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                              "${widget.message.user.firstName} ${widget.message.user.lastName}",
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(widget.message.content,
                          style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
                ),
              ),
            ),
            ReactionList(messageId: widget.message.id)
          ]),
          Row(
            children: [
              Text(widget.message.properDate,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(
                width: 8,
              ),
              CustomTextButton(
                  text: "Répondre...",
                  textColor: Colors.black,
                  onPressed: _onMessageAnswer)
            ],
          )
        ],
      ),
    );
  }
}
