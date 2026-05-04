import 'dart:io';
import 'package:flutter/material.dart';
import 'photo_gallery.dart';
import 'kubsau_news.dart';

void main() {
  try {
    HttpOverrides.global = MyHttpOverrides();
  } catch (e) {
  }
  runApp(const MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Лабораторная работа (Стабильные API)',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SelectionScreen(),
    );
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите приложение'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhotoGalleryApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Фотогалерея (Picsum)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KubsauNewsApp()),
                );
              },
              child: const Text('Новости (SpaceNews)'),
            ),
          ],
        ),
      ),
    );
  }
}
