import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/base/new_message_text_field.dart';
import 'package:flutter_frontend/widgets/messages_list.dart';

class CollaborativeSpace extends StatefulWidget {
  const CollaborativeSpace({super.key, required this.countryIndex});

  final int countryIndex;

  @override
  State<CollaborativeSpace> createState() => _CollaborativeSpaceState();
}

class _CollaborativeSpaceState extends State<CollaborativeSpace> {
  late Future<List<Message>> _messages;
  TextEditingController newMessageController = TextEditingController();
  bool _isInputNewMessageShown = false;

  Future<List<Message>> _fetchMessages() async {
    Dio dio = Dio();

    final response = await dio.get("$baseUrl/messages/${widget.countryIndex}");

    List<Message> messages = [];
    response.data.forEach((m) => messages.add(Message.fromJson(m)));

    return messages;
  }

  @override
  void initState() {
    _messages = _fetchMessages();
    super.initState();
  }

  void _updateMessages() {
    _messages = _fetchMessages();
    setState(() {});
  }

  Future<bool> _addMessage(String content, int userId, int countryId) async {
    Map<String, dynamic> body = {
      "content": content,
      "user": userId,
      "country": countryId
    };

    Dio dio = Dio();
    dio.options.headers["Authorization"] =
        "Token c29ec1e733d7fd6283fab3b94a18984d95a390b8";
    final response =
        await dio.post("$baseUrl/messages/create/", data: jsonEncode(body));

    if (response.statusCode == 201) {
      _updateMessages();
      return true;
    } else {
      // TODO: manage cases
      // print("An error occured when trying to create a message.");
      return false;
    }
  }

  void _onNewMessageSubmit() async {
    // poste un nouveau message en appelant l'API
    bool isMessageDone =
        await _addMessage(newMessageController.text, 10, widget.countryIndex);
    if (isMessageDone) {
      // toggle la variable d'état
      _toggleInputMessageShown();
    } else {}
  }

  void _toggleInputMessageShown() {
    // TODO: redirect user to connection/register if not logged in
    setState(() {
      _isInputNewMessageShown = !_isInputNewMessageShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _messages,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const CustomErrorWidget(
                  text:
                      "Nous n'avons pas réussi à afficher les messages. Veuillez réessayer plus tard.");
            } else {
              return snapshot.data!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Espace collaboratif",
                            style: Theme.of(context).textTheme.headlineMedium),
                        _isInputNewMessageShown
                            ? NewMessageTextField(
                                hintText: "Ecrire votre commentaire...",
                                controller: newMessageController,
                                onTap: _onNewMessageSubmit,
                                hide: _toggleInputMessageShown,
                              )
                            : CustomIconButton(
                                onPressed: _toggleInputMessageShown,
                                text: "Ajouter un message",
                                icon: Icons.add),
                        MessagesList(
                          messages: snapshot.data!,
                          countryIndex: widget.countryIndex,
                        )
                      ],
                    )
                  : Text("Aucun message n'a encore été publié.",
                      style: Theme.of(context).textTheme.bodyLarge);
            }
          } else {
            return const Loader();
          }
        }));
  }
}
