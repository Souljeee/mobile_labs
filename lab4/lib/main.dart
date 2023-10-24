import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _radiusFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          _radiusFocusNode.unfocus();
          _heightFocusNode.unfocus();
        },
        child: SafeArea(
          child: AppContent(
            radiusFocusNode: _radiusFocusNode,
            heightFocusNode: _heightFocusNode,
          ),
        ),
      ),
    );
  }
}

class CustomSnack extends StatelessWidget {
  const CustomSnack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/stop.jpg',
          height: 80,
          width: 80,
        ),
        const SizedBox(height: 16),
        const Text('Запрещен ввод отрицательных чисел'),
      ],
    );
  }
}

class AppContent extends StatefulWidget {
  final FocusNode radiusFocusNode;
  final FocusNode heightFocusNode;

  const AppContent({
    required this.radiusFocusNode,
    required this.heightFocusNode,
    super.key,
  });

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  String _square = 'Введите данные';

  final _dropdownMenuItems = ['+', '-', '/', '*'];

  final _radiusController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор'),
        actions: [
          DropdownButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: _dropdownMenuItems.map(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: _onDropDownMenuSelect,
          )
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          const Text(
            'Площадь',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _square,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              focusNode: widget.radiusFocusNode,
              controller: _radiusController,
              decoration: const InputDecoration(
                label: Text('Радиус'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigoAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              focusNode: widget.heightFocusNode,
              controller: _heightController,
              decoration: const InputDecoration(
                label: Text('Высота'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigoAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _calculateVolume(context: context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Посчитать',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _calculateVolume({required BuildContext context}) {
    final int radius = int.parse(_radiusController.value.text);
    final int height = int.parse(_heightController.value.text);

    if (radius < 0 || height < 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: CustomSnack()));

      widget.radiusFocusNode.unfocus();
      widget.heightFocusNode.unfocus();

      return;
    }

    final double square = 2 * pi * radius * (radius + height);

    setState(() {
      _square = square.toStringAsFixed(2);
    });

    widget.radiusFocusNode.unfocus();
    widget.heightFocusNode.unfocus();
  }

  void _onDropDownMenuSelect(String? value){
    switch(value){
      case '+':
        setState(() {
          _square = (double.parse(_square) + 1).toString();
        });
      case '-':
        setState(() {
          _square = (double.parse(_square) - 1).toString();
        });
      case '*':
        setState(() {
          _square = (double.parse(_square) * 2).toString();
        });
      case '/':
        setState(() {
          _square = (double.parse(_square) / 2).toString();
        });
    }
  }
}
