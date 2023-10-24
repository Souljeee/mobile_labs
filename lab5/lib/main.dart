import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Пятнашки',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<int> numbers;
  int size = 4; // размер игрового поля (4x4)

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    List<int> numbersList = List.generate(size * size, (index) => index);
    numbersList.shuffle();
    setState(() {
      numbers = numbersList;
    });
  }

  void _handleTap(int index) {
    if (isValidMove(index)) {
      setState(() {
        numbers.swap(index, numbers.indexOf(0));
      });
    }
  }

  bool isValidMove(int tappedIndex) {
    int emptyIndex = numbers.indexOf(0);
    List<int> validIndices = [];
    if (emptyIndex % size > 0) validIndices.add(emptyIndex - 1);
    if (emptyIndex % size < size - 1) validIndices.add(emptyIndex + 1);
    if (emptyIndex >= size) validIndices.add(emptyIndex - size);
    if (emptyIndex < size * (size - 1)) validIndices.add(emptyIndex + size);

    return validIndices.contains(tappedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Пятнашки',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.pink,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size,
              ),
              itemCount: size * size,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child:  Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: numbers[index] == 0 ? Colors.grey : Colors.pink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              iconSize: 50,
              color: Colors.pink,
              onPressed: startNewGame,
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        ),
      ),
    );
  }
}

extension ListExtensions<T> on List<T> {
  void swap(int i, int j) {
    T temp = this[i];
    this[i] = this[j];
    this[j] = temp;
  }
}
