import 'package:clock_app/src/enums.dart';
import 'package:clock_app/src/palette.dart';

import 'models/alarm_info.dart';
import 'models/menu-info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(menuType: MenuType.Clock, title: 'Clock', imageSource: 'assets/clock_icon.png'),
  MenuInfo(menuType: MenuType.Alarm, title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(menuType: MenuType.Timer, title: 'Timer', imageSource: 'assets/timer_icon.png'),
  MenuInfo(menuType: MenuType.Stopwatch, title: 'Stopwatch', imageSource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarmItems = [
  AlarmInfo(time: DateTime.now().add(Duration(hours: 1)), isActive: true, gradientColors: GradientTemplate.gradientTemplate[0].colors),
  AlarmInfo(time: DateTime.now().add(Duration(hours: 4)), isActive: true, gradientColors: GradientTemplate.gradientTemplate[1].colors),
  AlarmInfo(time: DateTime.now().add(Duration(minutes: 150)), isActive: true, gradientColors: GradientTemplate.gradientTemplate[2].colors),
];