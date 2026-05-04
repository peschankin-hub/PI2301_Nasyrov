class Resources {
  num _coffeBeans;
  num _milk;
  num _water;
  num _cash;

  Resources({
    num coffeBeans = 0,
    num milk = 0,
    num water = 0,
    num cash = 0,
  })  : _coffeBeans = coffeBeans,
        _milk = milk,
        _water = water,
        _cash = cash;

  num get coffeBeans => _coffeBeans;
  set coffeBeans(num value) => _coffeBeans = value;

  num get milk => _milk;
  set milk(num value) => _milk = value;

  num get water => _water;
  set water(num value) => _water = value;

  num get cash => _cash;
  set cash(num value) => _cash = value;

  num getResource(String type) {
    switch (type) {
      case 'coffeBeans':
        return _coffeBeans;
      case 'milk':
        return _milk;
      case 'water':
        return _water;
      case 'cash':
        return _cash;
      default:
        return 0;
    }
  }

  void setResource(String type, num value) {
    switch (type) {
      case 'coffeBeans':
        _coffeBeans = value;
        break;
      case 'milk':
        _milk = value;
        break;
      case 'water':
        _water = value;
        break;
      case 'cash':
        _cash = value;
        break;
    }
  }
}
