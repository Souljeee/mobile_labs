import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final latController = TextEditingController();
  final lonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: latController,
              decoration: InputDecoration(
                label: Text('Ширина'),
              ),
            ),
            TextField(
              controller: lonController,
              decoration: InputDecoration(
                label: Text('Долгота'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final isAvailable =
                    await MapLauncher.isMapAvailable(MapType.google);
                if (isAvailable!) {
                  await MapLauncher.showMarker(
                    mapType: MapType.google,
                    coords: Coords(
                      double.parse(latController.value.text),
                      double.parse(lonController.value.text),
                    ),
                    title: 'Это здесь!',
                  );
                }
              },
              child: Text('Показать'),
            ),
          ],
        ),
      ),
    );
  }
}
