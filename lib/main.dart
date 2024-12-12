import 'package:flutter/material.dart';
import 'package:qrcodescanner/splash_screen.dart';

void main() {
  runApp(const QrCodeScanner());
}

class QrCodeScanner extends StatelessWidget {
  const QrCodeScanner({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0.0),
      ),
      home: const SplashScreen(),
    );
  }
}
