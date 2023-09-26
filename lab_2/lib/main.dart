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
  String _square = 'Введите данные';

  final _radiusController = TextEditingController();
  final _heightController = TextEditingController();

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
          child: Scaffold(
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
                    focusNode: _radiusFocusNode,
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
                    focusNode: _heightFocusNode,
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
                            onPressed: _calculateVolume,
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
          ),
        ),
      ),
    );
  }

  void _calculateVolume() {
    final int radius = int.parse(_radiusController.value.text);
    final int height = int.parse(_heightController.value.text);

    final double square = 2 * pi * radius * (radius + height);

    setState(() {
      _square = square.toStringAsFixed(2);
    });

    _radiusFocusNode.unfocus();
    _heightFocusNode.unfocus();
  }
}
