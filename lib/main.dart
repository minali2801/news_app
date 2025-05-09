import 'package:flutter/material.dart';
import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/homescreen.dart';
import 'package:news_app/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedin = prefs.getBool('isLoggedin') ?? false;
  runApp(MyApp(isLoggedin: isLoggedin));
}

class MyApp extends StatefulWidget {
  final bool isLoggedin;

  const MyApp({super.key, required this.isLoggedin});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()), // NewsProvider
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
        ), // BookmarksProvider
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: widget.isLoggedin ? HomePage(toggleTheme: _toggleTheme,) : LoginPage(),
      ),
    );
  }
}
