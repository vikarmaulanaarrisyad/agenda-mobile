import 'package:agenda_mobile/presentation/pages/detail_agenda_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agenda_mobile/bloc/dashboard/dashboard_bloc.dart';
import 'package:agenda_mobile/data/models/request/agenda_request_model.dart';
import 'package:agenda_mobile/data/models/response/agenda_response_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(FetchAgendaEvent());
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
