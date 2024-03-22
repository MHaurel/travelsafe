import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/pages/country_page.dart';

class LastInfoCardSmall extends StatelessWidget {
  const LastInfoCardSmall({super.key, required this.lastInfo});

  final LastInfo lastInfo;

  @override
  Widget build(BuildContext context) {
    int timeElapsed = lastInfo.timeElapsed < 24
        ? lastInfo.timeElapsed
        : lastInfo.timeElapsed ~/ 24;
    String timeUnit = lastInfo.timeElapsed < 24 ? "h" : "j";

    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              CountryPage(countryIndex: lastInfo.country.id))),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0XFFD7D7D7)),
          ),
          width: MediaQuery.of(context).size.width * 0.2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lastInfo.country.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("$timeElapsed $timeUnit",
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0XFFD7D7D7)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(lastInfo.title,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
