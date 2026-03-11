import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Задание 2 название
      title: 'Инкремент',
      theme: ThemeData(
        // Задание 3 сменил тему
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreenAccent,
        ), //primarySwatch считается устаревшим. Использую colorScheme.
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Инкремент'), // Задание 2 смена заголовка
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // ++
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // --
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  // задание 10 - reset
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 4 задание - текст инкремента
            const Text(
              'Значение инкремента:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20), // Отступ
            // Задание 6 и 8 Кнопки - и + горизонтально рядом
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Кнопка Минус
                FloatingActionButton(
                  // Или ElevatedButton
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  backgroundColor: Colors.redAccent,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20), // Расстояние между кнопками
                // Плюс
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            // Задание 9 сброс
            TextButton(
              onPressed: _resetCounter,
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey, // Серый цвет текста
              ),
              child: const Text('Сбросить'),
            ),
          ],
        ),
      ),
      // Задание 5 - свойство floatingActionButton удалено
    );
  }
}
