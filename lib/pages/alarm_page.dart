import 'package:clock_app/src/palette.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../src/data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alarms',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: ListView(
              clipBehavior: Clip.none,
              children: alarmItems.map<Widget>((e) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: e.gradientColors),
                    boxShadow: [
                      BoxShadow(
                        color: e.gradientColors.last.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 4,
                        offset: const Offset(4, 4),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.label,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                e.name ?? 'Alarm',
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: e.isActive,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              e.isActive = !e.isActive;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Text(
                        DateFormat.E().format(e.time),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            DateFormat.jm().format(e.time),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).followedBy(
                [
                  DottedBorder(
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    strokeWidth: 3,
                    dashPattern: const [10,5],
                    radius: const Radius.circular(24),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Palette.clockBG,
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/add_alarm.png'),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Add alarm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
