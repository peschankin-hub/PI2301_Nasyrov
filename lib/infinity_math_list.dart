import 'package:flutter/material.dart';
import 'dart:math';

class InfinityMathList extends StatelessWidget {
  const InfinityMathList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Степени двойки')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final result = pow(2, index);
          print('Создан элемент $index, результат: $result');
          return ListTile(title: Text('2 ^ $index = $result'));
        },
      ),
    );
  }
}
