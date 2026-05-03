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
    final w = double.tryParse(_widthController.text) ?? 0.0;
    final h = double.tryParse(_heightController.text) ?? 0.0;
    setState(() {
      _width = w;
      _height = h;
      _result = w * h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const SizedBox(height: 16),
          Text(
            'Площадь: $_result',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
