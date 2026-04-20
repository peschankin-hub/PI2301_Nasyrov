import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const DormitoryScreen(),
    );
  }
}

class DormitoryScreen extends StatefulWidget {
  const DormitoryScreen({super.key});

  @override
  _DormitoryScreenState createState() => _DormitoryScreenState();
}

class _DormitoryScreenState extends State<DormitoryScreen> {
  bool _isLiked = false;
  int _likeCount = 27;

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likeCount -= 1;
        _isLiked = false;
      } else {
        _likeCount += 1;
        _isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const String descriptionText =
        'Студенческий городок или так называемый кампус Кубанского ГАУ состоит '
        'из двадцати общежитий, в которых проживает более 8000 студентов, что '
        'составляет 96% от всех нуждающихся. \n\n'
        'Студенты первого курса обеспечены местами в общежитии полностью. В '
        'соответствии с Положением о студенческих общежитиях университета, при '
        'поселении между администрацией и студентами заключается договор найма '
        'жилого помещения. \n\n'
        'Воспитательная работа в общежитиях направлена на улучшение быта, '
        'соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений '
        'в молодежной среде. Условия проживания в общежитиях университетского '
        'кампуса полностью отвечают санитарным нормам и требованиям: наличие '
        'оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат '
        'самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. \n\n'
        'С целью улучшения условий быта студентов активно работает система '
        'студенческого самоуправления — студенческие советы организуют всю работу по самообслуживанию.';

    return Scaffold(
      appBar: AppBar(title: const Text('Общежития КубГАУ')),
      body: ListView(
        children: [
          Image.asset(
            'images/1.png',
            width: 600,
            height: 320,
            fit: BoxFit.cover,
          ),

          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Общежитие №20',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        'Краснодар, ул. Калинина, 13',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: _toggleLike,
                ),
                Text('$_likeCount'),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.green, Icons.call, 'ПОЗВОНИТЬ'),
              _buildButtonColumn(Colors.green, Icons.near_me, 'МАРШРУТ'),
              _buildButtonColumn(Colors.green, Icons.share, 'ПОДЕЛИТЬСЯ'),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(32),
            child: const Text(descriptionText, softWrap: true),
          ),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: () {
            print('Нажата кнопка: $label');
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: color,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
