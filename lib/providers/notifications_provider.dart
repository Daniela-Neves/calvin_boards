import 'package:flutter/material.dart';
import '../models/app_notification.dart';

class NotificationsProvider extends ChangeNotifier {

  bool _disposed = false;

  final List<AppNotification> _notifications = [
    AppNotification(
        isRead: false,
        title: "Calvin Boards 0.2 lançado!",
        description:
            "Versão 0.2 conta correção de bugs e nova funcionalidade de "
            "notificações"),
    AppNotification(
        isRead: true,
        title: "Calvin Boards 0.1 lançado!",
        description:
            "A equipe da Calvin Group tem a felicidade de apresentar o "
            "aplicativo Calvin Boards, que tem como objetivo oferecer "
            "melhores entendimentos de como a dinâmica do agronegócio "
            "brasileiro afeta o mercado de caminhões no país."),
  ];

  void addNotification(AppNotification notification) {
    _notifications.add(notification);
    _notifications.sort((a, b) {
      if (a.isRead) {
        return -1;
      }
      return 1;
    });
    notifyListeners();
  }

  int count() {
    return _notifications.length;
  }

  int unreadCount() {
    return _notifications.where((element) => !element.isRead).length;
  }

  void toggleNotificationRead(int id) {
    AppNotification notification =
        _notifications.where((element) => element.id == id).first;
    notification.isRead = !notification.isRead;
    notifyListeners();
  }

  AppNotification? getById(int id) {
    try {
      return _notifications.where((element) => element.id == id).first;
    } on StateError {
      return null;
    }
  }

  AppNotification? getByIndex(int index) {
    return _notifications[index];
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
