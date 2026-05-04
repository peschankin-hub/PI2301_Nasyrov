import 'resources.dart';
import 'icoffee.dart';
import '../enums.dart';
import 'coffee_impl.dart';

class Machine {
  final Resources _resources;

  Machine(this._resources);

  num fillResources({num beans = 0, num milk = 0, num water = 0, num cash = 0}) {
    _resources.coffeBeans += beans;
    _resources.milk += milk;
    _resources.water += water;
    _resources.cash += cash;
    return 1;
  }

  String makeCoffeeByType(CoffeeType type) {
    ICoffee coffee;
    String coffeeName;
    switch (type) {
      case CoffeeType.espresso:
        coffee = Espresso();
        coffeeName = "Эспрессо";
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        coffeeName = "Капучино";
        break;
      case CoffeeType.americano:
        coffee = Americano();
        coffeeName = "Американо";
        break;
    }

    if (isAvailableResources(coffee)) {
      _makeCoffee(coffee);
      return "Ваш $coffeeName готов!";
    } else {
      String error = "Недостаточно ресурсов для $coffeeName:";
      if (_resources.coffeBeans < coffee.coffeBeans()) error += "\n- Кофе";
      if (_resources.water < coffee.water()) error += "\n- Вода";
      if (_resources.milk < coffee.milk()) error += "\n- Молоко";
      if (_resources.cash < coffee.cash()) error += "\n- Деньги";
      return error;
    }
  }

  bool isAvailableResources(ICoffee coffee) {
    return _resources.coffeBeans >= coffee.coffeBeans() &&
        _resources.milk >= coffee.milk() &&
        _resources.water >= coffee.water() &&
        _resources.cash >= coffee.cash();
  }

  void _makeCoffee(ICoffee coffee) {
    _resources.coffeBeans -= coffee.coffeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();
    _resources.cash -= coffee.cash();
  }

  Resources get resources => _resources;
}
