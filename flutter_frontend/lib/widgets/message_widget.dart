import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/new_message_text_field.dart';
import 'package:flutter_frontend/widgets/dialogs/connexion_dialog.dart';
import 'package:flutter_frontend/widgets/reaction_list.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget(
      {super.key,
      required this.message,
      required this.countryIndex,
      required this.updateMessages});

  final Message message;
  final int countryIndex;
  final Function() updateMessages;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool _isInputMessageShown = false;
  final TextEditingController _newMessageController = TextEditingController();

  void _toggleInputMessageShown() {
    if (context.read<UserProvider>().isSignedIn()) {
      setState(() {
        _isInputMessageShown = !_isInputMessageShown;
      });
    } else {
      showDialog(
          context: context, builder: (context) => const ConnexionDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    void onAnswerSubmit() async {
      // Send the message to the API
      Map<String, dynamic> body = {
        "content": _newMessageController.text,
        "user": context.read<UserProvider>().user.id,
        "country": widget.countryIndex,
        "parent": widget.message.id
      };

      bool hasWorked = await context.read<UserProvider>().postMessage(body);

      if (hasWorked) {
        widget.updateMessages();
      } else {
        // !
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                  onPressed: _toggleInputMessageShown)
            ],
          ),
          _isInputMessageShown
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: NewMessageTextField(
                        hintText: "Ecrire votre commentaire...",
                        controller: _newMessageController,
                        onTap: onAnswerSubmit,
                        hide: _toggleInputMessageShown,
                      ),
                    )
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
