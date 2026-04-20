import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Простой список')),
      body: ListView(
        children: const [
          ListTile(title: Text('0000')),
          Divider(),
          ListTile(title: Text('0001')),
          Divider(),
          ListTile(title: Text('0010')),
        ],
      ),
    );
  }
}
