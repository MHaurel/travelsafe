import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/widgets/last_info_card_large.dart';

class LastInfoList extends StatelessWidget {
  const LastInfoList({super.key, required this.lastInfos});

  final List<LastInfo> lastInfos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: lastInfos.length,
        itemBuilder:(context, index) => LastInfoCardLarge(lastInfo: lastInfos[index]),
      ),
    );
  }
}