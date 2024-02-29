import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/last_info.dart';

class LastInfoCardLarge extends StatelessWidget {
  const LastInfoCardLarge({super.key, required this.lastInfo});

  final LastInfo lastInfo;

  @override
  Widget build(BuildContext context) {
    int _timeElapsed = lastInfo.timeElapsed < 24
        ? lastInfo.timeElapsed
        : lastInfo.timeElapsed ~/ 24;
    String _timeUnit = lastInfo.timeElapsed < 24 ? "h" : "j";

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
                    Text(
                      lastInfo.country.name,
                      style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyLarge!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("$_timeElapsed $_timeUnit",
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    )
                  ],
                ),
                Text(lastInfo.title,
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
          )),
    );
  }
}
