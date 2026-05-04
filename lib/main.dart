import 'dart:io';
import 'package:flutter/material.dart';
import 'photo_gallery.dart';
import 'kubsau_news.dart';

void main() {
  // Для мобильных устройств оставляем на всякий случай
  try {
    HttpOverrides.global = MyHttpOverrides();
  } catch (e) {
    // В вебе HttpOverrides не поддерживается, это нормально
  }
  runApp(const MainApp());
}

// Заглушка для MyHttpOverrides, если она еще используется в kubsau_news.dart
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
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhotoGalleryApp()),
                );
              },
              label: const Text('Фотогалерея (Picsum)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.article),
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
              label: const Text('Новости (SpaceNews)'),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Эти API поддерживают CORS и работают в любом браузере.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
