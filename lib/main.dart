import 'package:eletroCar/pages/home_page.dart';
import 'package:eletroCar/pages/login_page.dart';
import 'package:eletroCar/pages/signup_page.dart';
import 'package:eletroCar/providers/signup_provider.dart';
import 'package:eletroCar/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      builder: (context, child) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt'),
        ],
        title: 'EletroCar',
        // theme: ThemeData(
        //     primarySwatch: Colors.indigo,
        //     buttonTheme: const ButtonThemeData(buttonColor: Colors.indigo),
        //     toggleButtonsTheme: const ToggleButtonsThemeData(
        //         selectedColor: Color.fromARGB(255, 83, 158, 99))),
        routes: {
          '/': (context) => const LoginPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage()
        },
        initialRoute: '/',
      ),
    );
  }
}
