import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/last_info_card_large.dart';
import 'package:provider/provider.dart';

class LastInfoList extends StatefulWidget {
  const LastInfoList({super.key, required this.lastInfos});

  final List<LastInfo> lastInfos;

  @override
  State<LastInfoList> createState() => _LastInfoListState();
}

class _LastInfoListState extends State<LastInfoList> {
  List<LastInfo> _visibleLastInfos = [];

  @override
  void initState() {
    _visibleLastInfos = widget.lastInfos;

    super.initState();
  }

  void _onChanged(bool b) {
    if (b) {
      _visibleLastInfos = widget.lastInfos
          .where((e) => context.read<UserProvider>().isSubbed(e.country))
          .toList();
    } else {
      _visibleLastInfos = widget.lastInfos;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.watch<UserProvider>().subscriptions.isNotEmpty
            ? Row(
                children: [
                  Text('Utiliser mes abonnements',
                      style: Theme.of(context).textTheme.bodyMedium),
                  CriteriaSwitch(onChanged: _onChanged),
                ],
              )
            : const SizedBox(),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: _visibleLastInfos.length,
            itemBuilder: (context, index) =>
                LastInfoCardLarge(lastInfo: _visibleLastInfos[index]),
          ),
        ),
      ],
    );
  }
}
