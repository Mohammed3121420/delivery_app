import 'package:flutter/material.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        HomeScreen.route: (context) => HomeScreen(),
      },
    );
  }
}
