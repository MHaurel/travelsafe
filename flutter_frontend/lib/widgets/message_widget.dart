import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/new_message_text_field.dart';
import 'package:flutter_frontend/widgets/reaction_list.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget(
      {super.key, required this.message, required this.countryIndex});

  final Message message;
  final int countryIndex;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool _isInputMessageShown = false;
  final TextEditingController _newMessageController = TextEditingController();

  void _toggleInputMessageShown() {
    // Display text field below
    setState(() {
      _isInputMessageShown = !_isInputMessageShown;
    });
  }

  void _onAnswerSubmit() async {
    // Send the message to the API

    Map<String, dynamic> body = {
      "content": _newMessageController.text,
      "user": 14,
      "country": widget.countryIndex,
      "parent": widget.message.id
    };

    print(body);

    // // TODO: code the function
    // Dio dio = Dio();
    // //! set headers with user token
    // final response =
    //     await dio.post("$baseUrl/messages/create/", data: jsonEncode(body));

    // if (response.statusCode == 201) {
    //   // success
    // } else {
    //   // fail
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: NewMessageTextField(
                        hintText: "Ecrire votre commentaire...",
                        controller: _newMessageController,
                        onTap: _onAnswerSubmit,
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
