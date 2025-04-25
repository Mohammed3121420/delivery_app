import 'dart:async';
import 'package:delivery_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SessionManager with WidgetsBindingObserver {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Timer? _inactivityTimer;
  final int timeoutInSeconds = 2 * 60; 
  late BuildContext _context;

  void start(BuildContext context) {
    _context = context;
    WidgetsBinding.instance.addObserver(this);
    _resetTimer();
  }

  void stop() {
    _inactivityTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  void userInteracted() {
    _resetTimer();
  }

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: timeoutInSeconds), _logoutUser);
  }

  void _logoutUser() {
    Navigator.of(_context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _inactivityTimer?.cancel();
      _inactivityTimer = Timer(Duration(seconds: timeoutInSeconds), _logoutUser);
    } else if (state == AppLifecycleState.resumed) {
      _resetTimer();
    }
  }
}
