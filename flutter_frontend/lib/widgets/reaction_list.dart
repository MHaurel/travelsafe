import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/reaction.dart';
import 'package:flutter_frontend/widgets/message_widget.dart';
import 'package:flutter_frontend/widgets/reaction_display.dart';

class ReactionList extends StatefulWidget {
  const ReactionList({super.key, required this.messageId});

  final int messageId;

  @override
  State<ReactionList> createState() => _ReactionListState();
}

class _ReactionListState extends State<ReactionList> {
  late Future<List<Reaction>> _reactions;
  late Map<dynamic, dynamic> _reactionsMapCount;

  Future<List<Reaction>> _fetchReactions() async {
    Dio dio = Dio();

    final response =
        await dio.get("$baseUrl/messages/reaction/${widget.messageId}");

    List<Reaction> reactions = [];
    response.data.forEach((r) => reactions.add(Reaction.fromJson(r)));

    return reactions;
  }

  void _onReactionTapped(Reaction reaction) {
    print("tapped on ${reaction.emoji.name}");
    print(Icons.thumb_up);
  }

  void _onReactionAdd() {
    // TODO:
    print("Asking to add a new reaction");
  }

  Map<dynamic, dynamic> _countReactions(List<Reaction> reactions) {
    Map<dynamic, dynamic> reactionsMapCount = {};

    reactions.forEach((element) {
      if (!reactionsMapCount.keys.contains(element.emoji.icon)) {
        reactionsMapCount[element.emoji.icon] = 0;
      }
      reactionsMapCount[element.emoji.icon] += 1;
    });

    return reactionsMapCount;
  }

  @override
  void initState() {
    _reactions = _fetchReactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _reactions,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // TODO: re-design the error widget
              return ErrorWidget("Could not fetch messages");
            } else {
              // Calculate the occurences of each reaction
              // FIXME: remove, this, we don't need the reactions variable anymore
              _reactionsMapCount = _countReactions(snapshot.data!);

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _reactionsMapCount.keys.length,
                        itemBuilder: (context, index) {
                          return ReactionDisplay(
                              leading: Text(_reactionsMapCount[
                                      _reactionsMapCount.keys.toList()[index]]
                                  .toString()), // FIXME:
                              icon: _reactionsMapCount.keys.toList()[index],
                              onTap: () =>
                                  _onReactionTapped(snapshot.data![index]));
                        },
                      ),
                      ReactionDisplay(
                          leading: Icon(Icons.emoji_emotions),
                          icon: Icons.add,
                          onTap: _onReactionAdd)
                    ],
                  ),
                ),
              );
            }
          } else {
            // ? Do nothing, just wait by displaying nothing.
            // return SizedBox();
            return const Center(
              child: Column(children: [
                SizedBox(
                  width: 20,
                  height: 20,
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