class OrdersModel {
  int? id;
  String? noPemesanan;
  String? namaLaundry;
  String? jenisPemesanan;
  DateTime? tanggalEstimasi;
  DateTime? tanggalPemesanan;
  String? namaPemesan;
  String? alamat;
  String? status;
  double? beratLaundry;
  double? totalHarga;

  OrdersModel({
    required this.id,
    required this.noPemesanan,
    required this.namaLaundry,
    required this.jenisPemesanan,
    required this.tanggalEstimasi,
    required this.tanggalPemesanan,
    required this.namaPemesan,
    required this.alamat,
    required this.status,
    this.beratLaundry,
    this.totalHarga,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'],
      noPemesanan: json['no_pemesanan'],
      namaLaundry: json['nama_laundry'],
      jenisPemesanan: json['jenis_pemesanan'],
      tanggalEstimasi: DateTime.parse(json['tanggal_estimasi']),
      tanggalPemesanan: DateTime.parse(json['tanggal_pemesanan']),
      namaPemesan: json['nama_pemesan'],
      alamat: json['alamat'],
      status: json['status'],
      beratLaundry: json['berat_laundry'] != null
          ? json['berat_laundry'].toDouble()
          : null,
      totalHarga:
          json['total_harga'] != null ? json['total_harga'].toDouble() : null,
    );
  }
}
