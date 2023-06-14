import 'dart:async';

import 'package:clock_app/src/enums.dart';
import 'package:clock_app/src/models/menu-info.dart';
import 'package:clock_app/src/palette.dart';
import 'package:clock_app/widgets/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../src/data.dart';
import 'clock_page.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: menuItems
                  .map((e) => buildTextButton(currentMenuInfo: e))
                  .toList(),
            ),
            const VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (BuildContext context, MenuInfo value, Widget? child) {
                  if (value.menuType == MenuType.Clock) {
                    return ClockPage(
                        dateTime: dateTime,
                        offsetSign: offsetSign,
                        timeZoneString: timeZoneString);
                  } else{
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextButton({
    required MenuInfo currentMenuInfo,
  }) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: (currentMenuInfo.menuType == value.menuType)
              ? Palette.menuBackgroundColor
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: TextButton(
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.5,
              ),
              Text(
                currentMenuInfo.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Avenir',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
