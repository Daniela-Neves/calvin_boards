import 'package:calvin_boards/pages/home_page.dart';
import 'package:calvin_boards/pages/login_page.dart';
import 'package:calvin_boards/pages/settings.dart';
import 'package:calvin_boards/pages/signup_page.dart';
import 'package:calvin_boards/providers/notifications_provider.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider())
      ],
      builder: (context, child) => MaterialApp(
        title: 'Calvin Boards',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            buttonTheme: const ButtonThemeData(buttonColor: Colors.indigo),
            toggleButtonsTheme: const ToggleButtonsThemeData(
                selectedColor: Color.fromARGB(255, 83, 158, 99))),
        routes: {
          '/': (context) => const LoginPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => const HomePage(),
          '/settings': (context) => const SettingsPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
