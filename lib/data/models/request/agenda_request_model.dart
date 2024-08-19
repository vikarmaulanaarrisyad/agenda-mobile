import 'dart:convert';

class AgendaModel {
  final int id;
  final int kategoriId;
  final int userId;
  final String namaKegiatan;
  final String tanggal;
  final String waktuMulai;
  final String tempat;
  final String createdAt;
  final String updatedAt;

  AgendaModel({
    required this.id,
    required this.kategoriId,
    required this.userId,
    required this.namaKegiatan,
    required this.tanggal,
    required this.waktuMulai,
    required this.tempat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgendaModel.fromJson(String str) =>
      AgendaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AgendaModel.fromMap(Map<String, dynamic> map) => AgendaModel(
        id: map['id'],
        kategoriId: map['kategori_id'],
        userId: map['user_id'],
        namaKegiatan: map['nama_kegiatan'],
        tanggal: map['tanggal'],
        waktuMulai: map['waktu_mulai'],
        tempat: map['tempat'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'kategori_id': kategoriId,
        'user_id': userId,
        'nama_kegiatan': namaKegiatan,
        'tanggal': tanggal,
        'waktu_mulai': waktuMulai,
        'tempat': tempat,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
