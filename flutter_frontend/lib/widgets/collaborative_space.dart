import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/criteria.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/models/risk.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/custom_text_field.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
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

  void _addMessage(String? content, int? userId, int? countryId) {
    // TODO: code function
    print("Content of the message: $content");
  }

  void _showAddMessageDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            SecondaryButton(
                onPressed: () => Navigator.of(context).pop(), text: "Annuler"),
            PrimaryButton(
                onPressed: () => _addMessage(controller.text, null, null),
                text: "Poster un message")
          ],
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contenu de votre message",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: "Message",
                  hintText: "Lorem ipsum dolor sit amet...",
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                )
              ],
            ),
          ),
        );
      },
    );
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
                            onPressed: () => _showAddMessageDialog(context),
                            text: "Ajouter un message",
                            icon: Icons.add),
                        MessagesList(messages: snapshot.data!)
                      ],
                    )
                  : Text("Aucun message n'a encore été publié.",
                      style: Theme.of(context).textTheme.bodyLarge);
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
