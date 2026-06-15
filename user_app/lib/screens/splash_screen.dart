import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFF10243E),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Icon(
                  Icons.campaign_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Lapor Desa',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF10243E),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Menyiapkan aplikasi...',
              style: TextStyle(color: Color(0xFF6B7A90)),
            ),
          ],
        ),
      ),
    );
  }
}

