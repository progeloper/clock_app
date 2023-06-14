import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/clock_view.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({
    super.key,
    required this.dateTime,
    required this.offsetSign,
    required this.timeZoneString,
  });

  final DateTime dateTime;
  final String offsetSign;
  final String timeZoneString;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color(0xFF2D2F41),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Clock',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.Hm().format(dateTime),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  DateFormat.MMMEd().format(dateTime),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Timezone',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      dateTime.timeZoneName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '(UTC $offsetSign $timeZoneString)',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}