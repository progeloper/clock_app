import 'dart:ui';

class AlarmInfo{
  DateTime time;
  String? name;
  bool isActive;
  List<Color> gradientColors;

  AlarmInfo({required this.time, this.name, required this.isActive, required this.gradientColors});
}