import 'package:flutter/material.dart';
import '../../data/services/login_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';

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

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    String userId = _userIdController.text.trim();
    String password = _passwordController.text.trim();
    String lang = '2'; // اللغة العربية

    final result = await _loginService.login(userId, password, lang);

    if (result['success']) {
      await _sharedPreferencesHelper.saveLoginStatus(true);
      await _sharedPreferencesHelper.saveUserName(result['name'] ?? '');

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _errorMessage = result['message'] ?? 'فشل تسجيل الدخول.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade400],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // عنوان الترحيب
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // نص الترحيب
                Text(
                  'Log back into your account',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),
                
                // بطاقة حقول الإدخال
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // حقل معرف المستخدم
                        TextField(
                          controller: _userIdController,
                          decoration: InputDecoration(
                            labelText: 'User ID',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        // حقل كلمة المرور
                        TextField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword ? Icons.visibility : Icons.visibility_off,
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
                        
                        // خيار "إظهار المزيد" (يمكن تطويره لاحقًا)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Show More',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        // زر تسجيل الدخول
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
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Log in',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                        
                        // رسالة الخطأ
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
      ),
    );
  }
}