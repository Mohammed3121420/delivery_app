import 'package:flutter/material.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../../../language/presentation/screen/language_selection_screen.dart';
import '../../data/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  final SharedPreferencesHelper _sharedPreferencesHelper =
      SharedPreferencesHelper();

  bool _isLoading = false;
  bool _showPassword = false;
  String _errorMessage = '';
  String _currentLanguage = 'ar'; // default

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    String userId = _userIdController.text.trim();
    String password = _passwordController.text.trim();
    String lang = _currentLanguage == 'en' ? '1' : '2';

    final result = await _loginService.login(userId, password, lang);

    if (result['success']) {
      await _sharedPreferencesHelper.saveLoginStatus(true);
      await _sharedPreferencesHelper.saveUserName(result['name'] ?? '');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _errorMessage =
            result['message'] ??
            (_currentLanguage == 'en' ? 'Login failed.' : 'فشل تسجيل الدخول.');
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _openLanguageSelection() async {
    final selectedLanguage = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
    );

    if (selectedLanguage != null) {
      setState(() {
        _currentLanguage = selectedLanguage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = _currentLanguage == 'en';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade400],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.language, color: Colors.white, size: 30),
                onPressed: _openLanguageSelection,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isEnglish ? 'Welcome Back!' : 'مرحباً بعودتك!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      isEnglish
                          ? 'Log back into your account'
                          : 'سجل الدخول إلى حسابك',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 40),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _userIdController,
                              decoration: InputDecoration(
                                labelText:
                                    isEnglish ? 'User ID' : 'معرف المستخدم',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                labelText:
                                    isEnglish ? 'Password' : 'كلمة المرور',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  isEnglish ? 'Show More' : 'إظهار المزيد',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: _isLoading ? null : _login,
                                child:
                                    _isLoading
                                        ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : Text(
                                          isEnglish ? 'Log in' : 'تسجيل الدخول',
                                          style: TextStyle(fontSize: 16),
                                        ),
                              ),
                            ),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
