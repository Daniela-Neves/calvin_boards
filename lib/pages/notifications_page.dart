import 'package:calvin_boards/components/default_drawer.dart';
import 'package:calvin_boards/models/app_notification.dart';
import 'package:calvin_boards/providers/notifications_provider.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationsProvider notificationsProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notificationsProvider = context.watch<NotificationsProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notificações")),
      drawer: ChangeNotifierProvider<SignUpProvider>.value(
          builder: (context, child) => DefaultDrawer(),
          value: Provider.of<SignUpProvider>(context)),
      body: ListView.builder(
          itemBuilder: _tileBuilder, itemCount: notificationsProvider.count()),
    );
  }

  Card _tileBuilder(_, int index) {
    AppNotification appNotification = notificationsProvider.getByIndex(index)!;
    final String title = appNotification.title;
    String subtitle = appNotification.description;

    FontWeight fontWeight = FontWeight.normal;

    if (!appNotification.isRead) {
      fontWeight = FontWeight.bold;
    }

    if (subtitle.length > 10) {
      // ignore: prefer_interpolation_to_compose_strings
      subtitle = subtitle.substring(0, 50) + '...';
    }

    return Card(
        child: ListTile(
            title: Text(title, style: TextStyle(fontWeight: fontWeight)),
            subtitle: Text(subtitle, style: TextStyle(fontWeight: fontWeight)),
            trailing: const Icon(Icons.arrow_forward)));
  }
}
