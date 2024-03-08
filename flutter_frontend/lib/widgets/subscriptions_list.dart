import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/subscription.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_outlined_icon_button.dart';
import 'package:provider/provider.dart';

class SubscriptionsList extends StatelessWidget {
  const SubscriptionsList(
      {super.key, required this.subs, required this.deleteSub});

  final List<Subscription> subs;
  final Function(Dio dio, int id) deleteSub;

  @override
  Widget build(BuildContext context) {
    return subs.isNotEmpty
        ? Expanded(
            child: ListView.builder(
            itemCount: subs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(subs[index].country.level.toString()), // TODO: svg
                        Text(subs[index].country.name)
                      ],
                    ),
                    CustomOutlinedIconButton(
                        onPressed: () => deleteSub(
                            Provider.of<UserProvider>(context, listen: false)
                                .dio,
                            subs[index].id),
                        text: "Abonné",
                        icon: Icons.check)
                  ],
                ),
              );
            },
          ))
        : Text("Vous ne vous êtes abonné à aucun pays pour l'instant.",
            style: Theme.of(context).textTheme.bodyLarge);
  }
}
