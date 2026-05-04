import 'package:flutter/material.dart';

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  double _width = 0.0;
  double _height = 0.0;
  double _result = 0.0;

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateArea() {
    final widthText = _widthController.text;
    final heightText = _heightController.text;

    if (widthText.isEmpty || heightText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
      return;
    }

    final w = double.tryParse(widthText);
    final h = double.tryParse(heightText);

    if (w == null || h == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите корректные числовые значения')),
      );
      return;
    }

    if (w <= 0 || h <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Значения должны быть больше нуля')),
      );
      return;
    }

    if (w > 1000000 || h > 1000000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Значения слишком большие!')),
      );
      return;
    }

    setState(() {
      _width = w;
      _height = h;
      _result = w * h;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Вычисление выполнено успешно')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор площади')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _widthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ширина',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Высота',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateArea,
              child: const Text('Вычислить'),
            ),
            const SizedBox(height: 24),
            if (_result > 0 || (_width > 0 && _height > 0))
              Text(
                'S = $_width * $_height = $_result',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
          ],
        ),
      ),
    );
  }
}
