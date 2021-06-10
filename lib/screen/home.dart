import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onMypagePressed;
  final VoidCallback onSettingsPressed;

  const HomeScreen(
      {Key? key,
      required this.onMypagePressed,
      required this.onSettingsPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('ホーム'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(12),
              ),
              onPressed: onMypagePressed,
              child: const Text('マイページ', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(12),
              ),
              onPressed: onSettingsPressed,
              child: const Text('設定', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
