import 'package:agenda_mobile/presentation/pages/detail_agenda_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agenda_mobile/bloc/dashboard/dashboard_bloc.dart';
import 'package:agenda_mobile/data/models/request/agenda_request_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Timer? _notificationCheckTimer;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(FetchAgendaEvent());

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    // Mulai timer untuk cek agenda setiap detik
    _notificationCheckTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      // _checkAndScheduleNotifications();
      _checkAndScheduleNotifications5();
    });
  }

  Future<void> _checkAndScheduleNotifications5() async {
    final state = context.read<DashboardBloc>().state;

    try {
      if (state is DashboardLoaded) {
        final tz.TZDateTime now =
            tz.TZDateTime.now(tz.getLocation('Asia/Jakarta'));
        print(now);

        for (final agenda in state.agendas) {
          final DateTime scheduledDateTime =
              DateTime.parse('${agenda.tanggal} ${agenda.waktuMulai}');
          final tz.TZDateTime scheduledTZDateTime = tz.TZDateTime.from(
              scheduledDateTime, tz.getLocation('Asia/Jakarta'));

          // Jika waktu agenda sama dengan waktu sekarang
          if (scheduledTZDateTime.year == now.year &&
              scheduledTZDateTime.month == now.month &&
              scheduledTZDateTime.day == now.day &&
              scheduledTZDateTime.hour == now.hour &&
              scheduledTZDateTime.minute == now.minute &&
              scheduledTZDateTime.second == now.second) {
            await flutterLocalNotificationsPlugin.show(
              agenda.id,
              agenda.namaKegiatan,
              'Tempat: ${agenda.tempat}',
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'agenda_notification_channel_id',
                  'Agenda Notifications',
                  channelDescription: 'Channel for agenda notifications',
                  importance: Importance.max,
                  priority: Priority.high,
                ),
              ),
              payload: 'Agenda ID: ${agenda.id}',
            );
          }
        }
      }
    } catch (e) {
      print('Error checking and scheduling notifications: $e');
    }
  }

  @override
  void dispose() {
    // Pastikan untuk membatalkan timer ketika widget dihancurkan
    _notificationCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DashboardBloc>().add(FetchAgendaEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            final List<AgendaModel> agendas = state.agendas;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemCount: agendas.length,
                itemBuilder: (context, index) {
                  final agenda = agendas[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        agenda.namaKegiatan,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tempat: ${agenda.tempat}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Tanggal: ${agenda.tanggal}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing:
                          Icon(Icons.event_note, color: Colors.deepPurple),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailAgendaPage(agenda: agenda),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is DashboardError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    Text('Error: ${state.message}',
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
