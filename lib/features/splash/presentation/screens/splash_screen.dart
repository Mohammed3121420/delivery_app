import 'package:delivery_app/features/auth/presentation/screens/login_screen.dart';
import 'package:delivery_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/shared_preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await SharedPreferencesHelper().getLoginStatus();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(
        context,
        HomeScreen.route,
      ); 
    } else {
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.route,
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(),
      ),
    );
  }
}
