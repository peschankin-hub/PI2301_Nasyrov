import 'package:flutter/material.dart';
import 'classes/machine.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: const CoffeeMachinePage(),
    );
  }
}

class CoffeeMachinePage extends StatefulWidget {
  const CoffeeMachinePage({super.key});

  @override
  State<CoffeeMachinePage> createState() => _CoffeeMachinePageState();
}

class _CoffeeMachinePageState extends State<CoffeeMachinePage> {
  // 8. Создание экземпляра класса
  late Machine machine;
  String statusMessage = "Добро пожаловать!";

  @override
  void initState() {
    super.initState();
    machine = Machine(
      coffeeBeans: 150,
      milk: 150,
      water: 300,
      cash: 0,
    );
  }

  void _buyCoffee(String type) {
    setState(() {
      statusMessage = machine.makingCoffee(type);
    });
  }

  void _fillResources() {
    setState(() {
      machine.addResources(100, 100, 200);
      statusMessage = "Ресурсы пополнены!";
    });
  }

  void _takeCash() {
    int amount = machine.resetCash();
    setState(() {
      statusMessage = "Вы забрали $amount руб.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кофемашина - Лаб 9'),
        backgroundColor: Colors.brown[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Панель состояния
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('СОСТОЯНИЕ РЕСУРСОВ', 
                      style: TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statusItem("Кофе", "${machine.coffeeBeans}г", Icons.grain),
                        _statusItem("Вода", "${machine.water}мл", Icons.water_drop),
                        _statusItem("Молоко", "${machine.milk}мл", Icons.coffee_maker),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Деньги: ${machine.cash} руб.', 
                      style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Дисплей
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontFamily: 'monospace'),
              ),
            ),

            const SizedBox(height: 30),
            const Text('ВЫБЕРИТЕ НАПИТОК:', textAlign: TextAlign.center),
            const SizedBox(height: 10),

            // Кнопки напитков
            Row(
              children: [
                Expanded(child: _coffeeButton("Эспрессо", "50р", () => _buyCoffee("эспрессо"))),
                const SizedBox(width: 8),
                Expanded(child: _coffeeButton("Капучино", "70р", () => _buyCoffee("капучино"))),
                const SizedBox(width: 8),
                Expanded(child: _coffeeButton("Латте", "90р", () => _buyCoffee("латте"))),
              ],
            ),

            const Spacer(),
            
            // Сервисные кнопки
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _fillResources,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Пополнить'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _takeCash,
                    icon: const Icon(Icons.money_off),
                    label: const Text('Забрать кассу'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.brown),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _coffeeButton(String name, String price, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: Colors.brown[50],
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(fontSize: 12, color: Colors.brown)),
        ],
      ),
    );
  }
}
