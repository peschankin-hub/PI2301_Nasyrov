// Лабораторная работа №2: Основы языка Dart
// Студент: [Твое Имя]

void main() {
  print('--- Задание 1: Фильтрация списка ---');
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('Исходный список: $numbers');
  print('Четные числа:');
  for (int number in numbers) {
    if (number % 2 == 0) {
      print('>> $number');
    }
  }

  print('\n--- Задание 2: Функции ---');
  int val = 7;
  print('Квадрат числа $val равен: ${square(val)}');

  print('\n--- Задание 3: ООП (Классы) ---');
  Student student = Student('Иван Иванов', 3);
  student.displayInfo();
}

// Функция для вычисления квадрата
int square(int n) => n * n;

// Класс Студент
class Student {
  final String name;
  final int course;

  Student(this.name, this.course);

  void displayInfo() {
    print('Студент: $name | Курс: $course');
  }
}
