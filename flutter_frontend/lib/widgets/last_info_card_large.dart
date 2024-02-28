import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/last_info.dart';

class LastInfoCardLarge extends StatelessWidget {
  const LastInfoCardLarge({super.key, required this.lastInfo});

  final LastInfo lastInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: (16.0)),
      child: Container(
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0XFFD7D7D7)),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(lastInfo.country.name),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined, size: 18,),
                      const SizedBox(width: 5,),
                      Text(lastInfo.createdAt.toLocal().toString())
                    ],
                  )
                ],
              ),
              Text(lastInfo.title)
            ],
          ),
        )
      ),
    );
  }
}