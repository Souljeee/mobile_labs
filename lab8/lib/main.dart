import 'package:flutter/material.dart';
import 'package:lab8/notification_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NotificationService notificationService;
  String text = '';

  @override
  void initState() {
    super.initState();

    notificationService = NotificationService();
    notificationService.initializePlatformNotifications();

    notificationService.stream.stream.listen(
      (event) {
        if (event.actionId == '1') {
          print('Хорошо');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => notificationService.showSimpleNotification(
                id: 0,
                title: "Drink Water",
                body: "Time to drink some water!",
                payload: "You just took water! Huurray!",
              ),
              child: const Text('Обычное'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => notificationService.showBigTextNotification(
                id: 1,
                title: "Drink Water",
                body: " Time to drink some water! Time to drink some water! Time to drink some water! Time to drink some water! Time to drink some water!Time to drink some water!Time to drink some water! Time to drink some water! Time to drink some water! ",
                payload: "You just took water! Huurray!",
              ),
              child: const Text('С большим текстом'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => notificationService.showBigPictureNotification(
                id: 2,
                title: "Drink Water",
                body: "Time to drink some water!",
                payload: "You just took water! Huurray!",
              ),
              child: const Text('С большой картинкой'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => notificationService.showInboxNotification(
                id: 3,
                title: "Drink Water",
                body: "Time to drink some water!",
                payload: "You just took water! Huurray!",
              ),
              child: const Text('Inbox'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => notificationService.showNotificationWithActions(
                id: 4,
                title: "Drink Water",
                body: "Time to drink some water!",
                payload: "You just took water! Huurray!",
              ),
              child: const Text('С кнопкой'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
