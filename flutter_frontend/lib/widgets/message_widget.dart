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
    print("Asking to answer message");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                          const CircleAvatar(
                            child: Icon(Icons.person_2),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                              "${widget.message.user.firstName} ${widget.message.user.lastName}")
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(widget.message.content)
                    ],
                  ),
                ),
              ),
            ),
            ReactionList(messageId: widget.message.id)
          ]),
          Row(
            children: [
              Text(
                  "${widget.message.dateCreated.day}/${widget.message.dateCreated.month}/${widget.message.dateCreated.year}"),
              const SizedBox(
                width: 20,
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
