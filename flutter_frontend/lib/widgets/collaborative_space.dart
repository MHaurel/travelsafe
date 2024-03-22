import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/base/new_message_text_field.dart';
import 'package:flutter_frontend/widgets/dialogs/connexion_dialog.dart';
import 'package:flutter_frontend/widgets/messages_list.dart';
import 'package:provider/provider.dart';

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
    Dio dio = context.read<UserProvider>().dio;
    final response = await dio.get("/messages/${widget.countryIndex}");

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

    bool hasWorked = await context.read<UserProvider>().postMessage(body);

    if (hasWorked) {
      _updateMessages();
      return true;
    } else {
      // !: manage cases
      // print("An error occured when trying to create a message.");
      return false;
    }
  }

  void _onNewMessageSubmit() async {
    // poste un nouveau message en appelant l'API
    bool isMessageDone = await _addMessage(newMessageController.text,
        context.read<UserProvider>().user.id!, widget.countryIndex);
    if (isMessageDone) {
      // toggle la variable d'état
      _toggleInputMessageShown();
    } else {}
  }

  void _toggleInputMessageShown() {
    setState(() {
      _isInputNewMessageShown = !_isInputNewMessageShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                onPressed: () {
                  if (Provider.of<UserProvider>(context, listen: false)
                      .isSignedIn()) {
                    _toggleInputMessageShown();
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => const ConnexionDialog());
                  }
                },
                text: "Ajouter un message",
                icon: Icons.add),
        FutureBuilder(
            future: _messages,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const CustomErrorWidget(
                      text:
                          "Nous n'avons pas réussi à afficher les messages. Veuillez réessayer plus tard.");
                } else {
                  return snapshot.data!.isNotEmpty
                      ? MessagesList(
                          messages: snapshot.data!,
                          countryIndex: widget.countryIndex,
                          updateMessages: _updateMessages,
                        )
                      : Text("Aucun message n'a encore été publié.",
                          style: Theme.of(context).textTheme.bodyLarge);
                }
              } else {
                return const Loader();
              }
            })),
      ],
    );
  }
}
