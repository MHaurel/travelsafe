import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/subscription.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/subscriptions_list.dart';
import 'package:provider/provider.dart';

class SubscriptionsDisplay extends StatefulWidget {
  const SubscriptionsDisplay({super.key});

  @override
  State<SubscriptionsDisplay> createState() => _SubscriptionsDisplayState();
}

class _SubscriptionsDisplayState extends State<SubscriptionsDisplay> {
  // ignore: unused_field
  late Future<List<Subscription>> _subs;

  void _onChanged(bool b) {
    // FIXME: implement the notification preferences of the user
  }

  Future<List<Subscription>> _fetchSubs(Dio dio) async {
    Response response = await dio.get("/subscription/");

    List<Subscription> subs = [];
    response.data.forEach((s) => subs.add(Subscription.fromJson(s)));
    return subs;
  }

  @override
  void initState() {
    _subs = _fetchSubs(Provider.of<UserProvider>(context, listen: false).dio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Abonnements",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recevoir des mails d'alertes",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 16,
              ),
              CriteriaSwitch(
                onChanged: _onChanged,
              )
            ],
          ),
          SubscriptionsList(
            subs: context.watch<UserProvider>().subscriptions,
          )
        ],
      ),
    );
  }
}
