import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _loginStatusKey = 'isLoggedIn';
  static const String _userNameKey =
      'deliveryUserName'; 


  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginStatusKey, isLoggedIn);
  }


  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginStatusKey) ??
        false; 
  }

  Future<void> saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }


  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      _userNameKey,
    ); 
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
