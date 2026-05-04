import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News {
  final String title;
  final String publishedAt;
  final String summary;
  final String imageUrl;

  News({
    required this.title,
    required this.publishedAt,
    required this.summary,
    required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: Bidi.stripHtmlIfNeeded(json['title'] ?? ''),
      publishedAt: json['published_at'] ?? '',
      summary: Bidi.stripHtmlIfNeeded(json['summary'] ?? ''),
      imageUrl: json['image_url'] ?? '',
    );
  }
}

Future<List<News>> fetchNews() async {
  try {
    // Используем Spaceflight News API - отличный аналог, работает везде
    final response = await http.get(
      Uri.parse('https://api.spaceflightnewsapi.net/v4/articles/?limit=10'),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> results = data['results'];
      return results.map((dynamic item) => News.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка сервера: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Не удалось загрузить новости: $e');
  }
}

class KubsauNewsApp extends StatelessWidget {
  const KubsauNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мировые Новости (Аналог)',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const NewsListPage(),
    );
  }
}

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости Технологий'),
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  News news = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (news.imageUrl.isNotEmpty)
                          Image.network(
                            news.imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                                const Icon(Icons.broken_image, size: 100),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                news.publishedAt.split('T')[0], // Упрощаем дату
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                news.summary,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("${snapshot.error}", textAlign: TextAlign.center),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
