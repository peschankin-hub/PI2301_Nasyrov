import 'icoffee.dart';
import '../async_methods.dart';

class Espresso implements ICoffee {
  Espresso._internal();

  factory Espresso() {
    var instance = Espresso._internal();
    instance.prepare(); // Fire and forget as per factory constructor limitation
    return instance;
  }

  @override
  Future<void> prepare() async {
    print('---------------------------------');
    print('_start_');
    await heatWater();
    print('_then_');
    await brewCoffee();
    print('_end_');
  }

  @override
  num coffeBeans() => 20;
  @override
  num milk() => 0;
  @override
  num water() => 50;
  @override
  num cash() => 50;
}

class Cappuccino implements ICoffee {
  Cappuccino._internal();

  factory Cappuccino() {
    var instance = Cappuccino._internal();
    instance.prepare();
    return instance;
  }

  @override
  Future<void> prepare() async {
    print('---------------------------------');
    print('_start_');
    await heatWater();
    print('_then_');
    await Future.wait([brewCoffee(), frothMilk()]);
    await mixCoffeeAndMilk();
    print('_end_');
  }

  @override
  num coffeBeans() => 20;
  @override
  num milk() => 100;
  @override
  num water() => 50;
  @override
  num cash() => 80;
}

class Americano implements ICoffee {
  Americano._internal();

  factory Americano() {
    var instance = Americano._internal();
    instance.prepare();
    return instance;
  }

  @override
  Future<void> prepare() async {
    print('---------------------------------');
    print('_start_');
    await heatWater();
    print('_then_');
    await brewCoffee();
    print('_end_');
  }

  @override
  num coffeBeans() => 20;
  @override
  num milk() => 0;
  @override
  num water() => 150;
  @override
  num cash() => 60;
}
