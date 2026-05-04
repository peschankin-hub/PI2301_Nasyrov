import 'package:flutter/material.dart';
import 'classes/machine.dart';
import 'classes/resources.dart';
import 'enums.dart';
import 'pages/coffee_maker_page.dart';
import 'pages/resources_page.dart';

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
      home: const MainContainer(),
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  late Machine machine;

  @override
  void initState() {
    super.initState();
    machine = Machine(
      Resources(coffeBeans: 250, milk: 250, water: 250, cash: 0),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _buyCoffee(CoffeeType type) async {
    _showSnackBar("Начинаю приготовление...");
    
    String result = await machine.makeCoffeeByType(type);
    
    if (mounted) {
      setState(() {});
      _showSnackBar(result);
    }
  }

  void _addMoney(num amount) {
    setState(() {
      machine.fillResources(cash: amount);
    });
    _showSnackBar("Внесено $amount руб.");
  }

  void _fillResources({num beans = 0, num milk = 0, num water = 0, num cash = 0}) {
    setState(() {
      machine.fillResources(beans: beans, milk: milk, water: water, cash: cash);
    });
    _showSnackBar("Ресурсы обновлены");
  }

  void _takeChange() {
    num amount = machine.resources.cash;
    setState(() {
      machine.resources.cash = 0;
    });
    _showSnackBar("Ваша сдача: $amount руб.");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Кофемашина"),
          backgroundColor: Colors.brown[300],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.coffee)),
              Tab(icon: Icon(Icons.local_shipping)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoffeeMakerPage(
              machine: machine,
              onBuy: _buyCoffee,
              onAddMoney: _addMoney,
              onTakeChange: _takeChange,
            ),
            ResourcesPage(
              machine: machine,
              onFill: _fillResources,
            ),
          ],
        ),
      ),
    );
  }
}
