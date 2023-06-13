import 'package:clock_app/src/enums.dart';

import 'models/menu-info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(menuType: MenuType.Clock, title: 'Clock', imageSource: 'assets/clock-icon.png'),
  MenuInfo(menuType: MenuType.Alarm, title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(menuType: MenuType.Timer, title: 'Timer', imageSource: 'assets/timer_icon.png'),
  MenuInfo(menuType: MenuType.Stopwatch, title: 'Stopwatch', imageSource: 'assets/stopwatch_icon.png'),
];