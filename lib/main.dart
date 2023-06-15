import 'dart:async';

import 'package:clock_app/pages/home_page.dart';
import 'package:clock_app/src/enums.dart';
import 'package:clock_app/src/models/menu-info.dart';
import 'package:clock_app/src/models/notification_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';


int id = 0;

int navigationActionId = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final StreamController<NotificationInfo> didReceiveLocalNotificationStream =
StreamController<NotificationInfo>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

const MethodChannel platform =
MethodChannel('com.mayeaux/alarms');

const String portName = 'notification_send_port';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  //assuming the notification has an input field
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('flutter_icon');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D2F41)),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(menuType: MenuType.Clock, title: 'Clock', imageSource: 'assets/clock_icon.png'),
        child: const HomePage(),
      ),
    );
  }
}
