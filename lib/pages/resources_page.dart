import 'package:flutter/material.dart';
import '../classes/machine.dart';

class ResourcesPage extends StatefulWidget {
  final Machine machine;
  final Function({num beans, num milk, num water, num cash}) onFill;

  const ResourcesPage({
    super.key,
    required this.machine,
    required this.onFill,
  });

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final TextEditingController _milkController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _beansController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();

  @override
  void dispose() {
    _milkController.dispose();
    _waterController.dispose();
    _beansController.dispose();
    _cashController.dispose();
    super.dispose();
  }

  void _handleFill() {
    widget.onFill(
      milk: num.tryParse(_milkController.text) ?? 0,
      water: num.tryParse(_waterController.text) ?? 0,
      beans: num.tryParse(_beansController.text) ?? 0,
      cash: num.tryParse(_cashController.text) ?? 0,
    );
    _milkController.clear();
    _waterController.clear();
    _beansController.clear();
    _cashController.clear();
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
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Ресурсы:",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("Молоко: ${widget.machine.resources.milk}"),
                      Text("Вода: ${widget.machine.resources.water}"),
                      Text("Зерна: ${widget.machine.resources.coffeBeans}"),
                      Text("Деньги: ${widget.machine.resources.cash}"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInputField(_milkController, "добавить молоко"),
                    _buildInputField(_waterController, "добавить воду"),
                    _buildInputField(_beansController, "добавить зерна"),
                    _buildInputField(_cashController, "добавить деньги"),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          icon: const Icon(Icons.add),
                          onPressed: _handleFill,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton.filled(
                          icon: const Icon(Icons.add),
                          onPressed: _handleFill,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
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

  Widget _buildInputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
