import 'dart:async';

import 'package:clock_app/src/models/menu-info.dart';
import 'package:clock_app/widgets/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    var timeZoneString = dateTime.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneString.startsWith('-')) offsetSign = '+';
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                buildTextButton(asset: 'assets/clock_icon.png', label: 'Clock'),
                buildTextButton(asset: 'assets/alarm_icon.png', label: 'Alarm'),
                buildTextButton(asset: 'assets/timer_icon.png', label: 'Timer'),
                buildTextButton(
                    asset: 'assets/stopwatch_icon.png', label: 'Stopwatch'),
              ],
            ),
            const VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            Expanded(
              child: Container(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextButton({
    required String asset,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
        onPressed: () {
          var menuInfo = Provider.of<MenuInfo>(context);
          menuInfo.updateMenu(currentMenuInfo);
        },
        child: Column(
          children: [
            Image.asset(
              asset,
              scale: 1.5,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Avenir',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
