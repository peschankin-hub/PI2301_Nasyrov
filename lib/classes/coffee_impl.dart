import 'icoffee.dart';

class Espresso implements ICoffee {
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
  @override
  num coffeBeans() => 20;
  @override
  num milk() => 0;
  @override
  num water() => 150;
  @override
  num cash() => 60;
}
