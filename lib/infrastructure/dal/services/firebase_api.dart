import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  static Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();
    FirebaseApi.initLocalNotification();
    FirebaseMessaging.onMessage.listen(FirebaseApi.handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(FirebaseApi.handleBackgroundMessage);
    print(token);
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  static Future<void> handleMessage(RemoteMessage message) async {
    RemoteNotification notification = message.notification!;

    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      payload: json.encode(message.data),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    final data = message.data;
    print(data);
  }

  static Future<void> handleForegroundMessage(RemoteMessage message) async {
    final data = message.data;
    if (data['route'] != null) {
      Get.toNamed(data['route'], arguments: [data['data'], 'order']);
    }
  }

  static void onSelectNotification(NotificationResponse details) {
    final payload = json.decode(details.payload!);
    if (payload['route'] != null) {
      Get.toNamed(payload['route'], arguments: [payload['datagit '], 'order']);
    }
  }
}
