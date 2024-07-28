class OrdersModel {
  int? id;
  String? noPemesanan;
  String? namaLaundry;
  String? jenisPemesanan;
  String? namaPemesan;
  double? beratLaundry;
  double? totalHarga;

  OrdersModel({
    required this.id,
    required this.noPemesanan,
    required this.namaLaundry,
    required this.jenisPemesanan,
    required this.namaPemesan,
    this.beratLaundry,
    this.totalHarga,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'],
      noPemesanan: json['no_pemesanan'],
      namaLaundry: json['nama_laundry'],
      jenisPemesanan: json['jenis_pemesanan'],
      namaPemesan: json['nama_pemesan'],
      beratLaundry: json['berat_laundry'] != null
          ? json['berat_laundry'].toDouble()
          : null,
      totalHarga:
          json['total_harga'] != null ? json['total_harga'].toDouble() : null,
    );
  }
}
