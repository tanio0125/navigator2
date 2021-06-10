import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

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
              onPressed: () {
                Routemaster.of(context).push('/mypage');
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
