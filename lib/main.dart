import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remindmeof/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remindmeof/mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('remindmeof');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future<dynamic> onSelectNotification(String x) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MainPage();
    }));
  }

  final MaterialColor kPrimaryColor = const MaterialColor(
    0xff84f8c0,
    const <int, Color>{
      50: const Color(0xff84f8c0),
      100: const Color(0xff84f8c0),
      200: const Color(0xff84f8c0),
      300: const Color(0xff84f8c0),
      400: const Color(0xff84f8c0),
      500: const Color(0xff84f8c0),
      600: const Color(0xff84f8c0),
      700: const Color(0xff84f8c0),
      800: const Color(0xff84f8c0),
      900: const Color(0xff84f8c0),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remind Me Of',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        primaryColor: Color(0xff84f8c0),
        accentColor: Color(0xffD9D9D9),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: LoginPage(),
    );
  }
}
