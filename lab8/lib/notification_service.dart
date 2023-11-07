import 'dart:async';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final StreamController<NotificationResponse> stream =
      StreamController.broadcast();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
    );
  }

  void selectNotification(NotificationResponse response) {
    if (response.payload != null && response.payload!.isNotEmpty) {
      stream.add(response);
    }
  }

  Future<NotificationDetails> _notificationDetails(
      {required AndroidNotificationDetails detailsNotif}) async {
    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      stream.add(details.notificationResponse!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: detailsNotif,
    );

    return platformChannelSpecifics;
  }

  Future<void> showSimpleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      color: const Color(0xff2196f3),
    );

    final platformChannelSpecifics = await _notificationDetails(
        detailsNotif: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    BigTextStyleInformation information = BigTextStyleInformation(body);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      styleInformation: information,
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      color: const Color(0xff2196f3),
    );

    final platformChannelSpecifics = await _notificationDetails(
        detailsNotif: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showInboxNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    const List<String> lines = <String>[
      'Alex Faarborg  Check this out',
      'Jeff Chang    Launch Party'
    ];
    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        contentTitle: '2 messages',
        summaryText: 'janedoe@example.com');

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      styleInformation: inboxStyleInformation,
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      color: const Color(0xff2196f3),
    );

    final platformChannelSpecifics = await _notificationDetails(
        detailsNotif: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showBigPictureNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    const BigPictureStyleInformation inboxStyleInformation =
        BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      hideExpandedLargeIcon: false,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      styleInformation: inboxStyleInformation,
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      color: const Color(0xff2196f3),
    );

    final platformChannelSpecifics = await _notificationDetails(
        detailsNotif: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showNotificationWithActions({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      color: const Color(0xff2196f3),
      actions: [
        AndroidNotificationAction(
          '1',
          'Хорошо',
          showsUserInterface: true,
        ),
      ],
    );

    final platformChannelSpecifics = await _notificationDetails(
        detailsNotif: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
