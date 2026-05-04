import 'package:flutter/material.dart';
import '../classes/machine.dart';
import '../enums.dart';

class CoffeeMakerPage extends StatefulWidget {
  final Machine machine;
  final Function(CoffeeType) onBuy;
  final Function(num) onAddMoney;
  final VoidCallback onTakeChange;

  const CoffeeMakerPage({
    super.key,
    required this.machine,
    required this.onBuy,
    required this.onAddMoney,
    required this.onTakeChange,
  });

  @override
  State<CoffeeMakerPage> createState() => _CoffeeMakerPageState();
}

class _CoffeeMakerPageState extends State<CoffeeMakerPage> {
  CoffeeType _selectedType = CoffeeType.espresso;
  final TextEditingController _moneyController = TextEditingController();

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Зерна: ${widget.machine.resources.coffeBeans}"),
                  Text("Молоко: ${widget.machine.resources.milk}"),
                  Text("Вода: ${widget.machine.resources.water}"),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Кофеварка",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Ваши деньги: ${widget.machine.resources.cash}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    RadioListTile<CoffeeType>(
                      title: const Text("эспрессо - 50р"),
                      value: CoffeeType.espresso,
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() => _selectedType = value!);
                      },
                    ),
                    RadioListTile<CoffeeType>(
                      title: const Text("капучино - 80р"),
                      value: CoffeeType.cappuccino,
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() => _selectedType = value!);
                      },
                    ),
                    RadioListTile<CoffeeType>(
                      title: const Text("американо - 60р"),
                      value: CoffeeType.americano,
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() => _selectedType = value!);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton.filled(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () => widget.onBuy(_selectedType),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _moneyController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Положите деньги сюда",
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton.filled(
                          icon: const Icon(Icons.attach_money),
                          onPressed: () {
                            if (_moneyController.text.isNotEmpty) {
                              widget.onAddMoney(num.parse(_moneyController.text));
                              _moneyController.clear();
                            }
                          },
                          style: IconButton.styleFrom(backgroundColor: Colors.green[400]),
                        ),
                        const SizedBox(width: 5),
                        IconButton.filled(
                          icon: const Icon(Icons.sync_alt),
                          onPressed: widget.onTakeChange,
                          style: IconButton.styleFrom(backgroundColor: Colors.pink[200]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
