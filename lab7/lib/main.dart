import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrices/matrices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _m = 0;
  int _n = 0;

  final _mFocusNode = FocusNode();
  final _nFocusNode = FocusNode();

  final _mController = TextEditingController();
  final _nController = TextEditingController();

  late Matrix matrix;
  final List<double> matrixSource = [];
  final List<int> negative = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? SafeArea(
                    child: Column(
                      children: [
                        if (_m == 0 || _n == 0)
                          const Spacer()
                        else
                          Expanded(
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _m,
                              ),
                              children: List.generate(
                                _m * _n,
                                (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                      child: Text(
                                        matrixSource[index].toInt().toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            focusNode: _mFocusNode,
                            controller: _mController,
                            decoration: const InputDecoration(
                              label: Text('Высота'),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.indigoAccent,
                                  width: 3,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            focusNode: _nFocusNode,
                            controller: _nController,
                            decoration: const InputDecoration(
                              label: Text('Высота'),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.indigoAccent,
                                  width: 3,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
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
                                    onPressed: () {
                                      setState(() {
                                        negative.clear();
                                        matrixSource.clear();

                                        _m = int.parse(_mController.text);
                                        _n = int.parse(_nController.text);

                                        matrixSource.addAll(List.generate(
                                          _m * _n,
                                          (index) {
                                            final int randomNumber =
                                                Random().nextInt(100) -
                                                    Random().nextInt(100);

                                            return randomNumber.toDouble();
                                          },
                                        ));

                                        matrix = Matrix.fromFlattenedList(
                                          matrixSource,
                                          _n,
                                          _m,
                                        );

                                        _calculateNegative();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                  )
                : SafeArea(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: negative.map(
                          (element) {
                            return Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Text(
                                  element.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _calculateNegative(){
    for(int i = 0; i < matrix.matrix.length; i ++){
      for (int j = 0; j < matrix.matrix[i].length; j ++){
        if(matrix.matrix[i][j] < 0){
          negative.add(j + 1);

          break;
        }
      }

      if(negative.length != i + 1){
        negative.add(0);
      }
    }
  }
}
