import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguage = 'en'; // القيمة الافتراضية

  void applyLanguage() {
    if (selectedLanguage != null) {
      Navigator.pop(context, selectedLanguage);
    }
  }

  Widget languageOption({
    required String languageCode,
    required String title,
    required String subtitle,
    required String flagAsset,
  }) {
    final isSelected = selectedLanguage == languageCode;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = languageCode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[100] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 16, backgroundImage: AssetImage(flagAsset)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Language',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: languageOption(
                      languageCode: 'ar',
                      title: 'العربية',
                      subtitle: 'Arabic',
                      flagAsset: 'assets/flags/saudi.png',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: languageOption(
                      languageCode: 'en',
                      title: 'English',
                      subtitle: 'English',
                      flagAsset: 'assets/flags/uk.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: applyLanguage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[800],
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Apply', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
