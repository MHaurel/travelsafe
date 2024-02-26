import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/criteria.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/models/risk.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/messages_list.dart';

class CollaborativeSpace extends StatefulWidget {
  const CollaborativeSpace({super.key, required this.countryIndex});

  final int countryIndex;

  @override
  State<CollaborativeSpace> createState() => _CollaborativeSpaceState();
}

class _CollaborativeSpaceState extends State<CollaborativeSpace> {
  late Future<List<Message>> _messages;

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

  void _addMessage() {
    // TODO: code function
    print("Asking to add message");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _messages,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // TODO: re-design the error widget
              return ErrorWidget("Could not fetch messages");
            } else {
              return snapshot.data!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Espace collaboratif",
                            style: Theme.of(context).textTheme.headlineMedium),
                        CustomIconButton(
                            onPressed: _addMessage,
                            text: "Ajouter un message",
                            icon: Icons.add),
                        MessagesList(messages: snapshot.data!)
                      ],
                    )
                  : const Text("Aucun message n'a encore été publié.");
            }
          } else {
            return const Center(
              child: Column(children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ]),
            );
          }
        }));
  }
}
