import 'package:clock_app/src/enums.dart';
import 'package:flutter/foundation.dart';

class MenuInfo extends ChangeNotifier{
  MenuType menuType;
  String title;
  String imageSource;
  MenuInfo({
    required this.menuType,
    required this.title,
    required this.imageSource,
  });

  updateMenu(MenuInfo menuInfo){
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}