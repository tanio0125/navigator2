import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class MypageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('マイページ'),
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
              onPressed: () {
                Routemaster.of(context).push('/mypage/settings');
              },
              child: const Text('マイページ', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(12),
              ),
              onPressed: () {
                Routemaster.of(context).push('/settings');
              },
              child: const Text('設定', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
