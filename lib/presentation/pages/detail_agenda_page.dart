// detail_agenda_page.dart
import 'package:agenda_mobile/data/models/request/agenda_request_model.dart';
import 'package:flutter/material.dart';
import 'package:agenda_mobile/data/models/response/agenda_response_model.dart';

class DetailAgendaPage extends StatelessWidget {
  final AgendaModel agenda;

  const DetailAgendaPage({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(agenda.namaKegiatan),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Kegiatan: ${agenda.namaKegiatan}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Tempat: ${agenda.tempat}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Tanggal: ${agenda.tanggal}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
