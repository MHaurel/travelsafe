import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/subscription.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_outlined_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SubscriptionsList extends StatelessWidget {
  const SubscriptionsList({super.key, required this.subs});

  final List<Subscription> subs;

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
                        SvgPicture.asset(
                          "assets/images/RiskLevel${subs[index].country.level}.svg",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(subs[index].country.name)
                      ],
                    ),
                    CustomOutlinedIconButton(
                        onPressed: () => context
                            .read<UserProvider>()
                            .unsubscribe(subs[index].country.id),
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
