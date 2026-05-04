class Machine {
  int _coffeeBeans;
  int _milk;
  int _water;
  int _cash;

  Machine({
    int coffeeBeans = 0,
    int milk = 0,
    int water = 0,
    int cash = 0,
  })  : _coffeeBeans = coffeeBeans,
        _milk = milk,
        _water = water,
        _cash = cash;

  // 4. Геттеры и сеттеры
  int get coffeeBeans => _coffeeBeans;
  set coffeeBeans(int value) => _coffeeBeans = value;

  int get milk => _milk;
  set milk(int value) => _milk;

  int get water => _water;
  set water(int value) => _water;

  int get cash => _cash;
  set cash(int value) => _cash;

  // 5. Проверка доступности ресурсов
  bool isAvailable({int b = 50, int w = 100, int m = 0}) {
    return _coffeeBeans >= b && _water >= w && _milk >= m;
  }

  // 6. Закрытый метод уменьшения ресурсов (для эспрессо по умолчанию)
  void _subtractResources({int b = 50, int w = 100, int m = 0}) {
    _coffeeBeans -= b;
    _water -= w;
    _milk -= m;
  }

  // 7. Метод makingCoffee
  // Возвращает строку с результатом для отображения в UI
  String makingCoffee(String type) {
    int b = 50;
    int w = 100;
    int m = 0;
    int price = 0;

    switch (type.toLowerCase()) {
      case 'эспрессо':
        price = 50;
        break;
      case 'капучино':
        m = 50;
        price = 70;
        break;
      case 'латте':
        m = 100;
        price = 90;
        break;
      default:
        return "Неизвестный тип кофе.";
    }

    if (isAvailable(b: b, w: w, m: m)) {
      _subtractResources(b: b, w: w, m: m);
      _cash += price;
      return "Ваш $type готов!";
    } else {
      String error = "Недостаточно ресурсов:";
      if (_coffeeBeans < b) error += "\n- Кофе ($bг)";
      if (_water < w) error += "\n- Вода ($wмл)";
      if (_milk < m) error += "\n- Молоко ($mмл)";
      return error;
    }
  }

  void addResources(int b, int m, int w) {
    _coffeeBeans += b;
    _milk += m;
    _water += w;
  }

  int resetCash() {
    int current = _cash;
    _cash = 0;
    return current;
  }
}
