class OrdersModel {
  int? id;
  String? noPemesanan;
  String? jenisPemesanan;
  String? namaPemesan;
  String? nomorTelepon;
  String? alamat;
  String? beratLaundry;
  String? totalHarga;
  String? paymentMethod;
  String? tanggalPemesanan;
  String? tanggalPengambilan;
  String? laundryId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  OrdersModel(
      {this.id,
      this.noPemesanan,
      this.jenisPemesanan,
      this.namaPemesan,
      this.nomorTelepon,
      this.alamat,
      this.beratLaundry,
      this.totalHarga,
      this.paymentMethod,
      this.tanggalPemesanan,
      this.tanggalPengambilan,
      this.laundryId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noPemesanan = json['no_pemesanan'];
    jenisPemesanan = json['jenis_pemesanan'];
    namaPemesan = json['nama_pemesan'];
    nomorTelepon = json['nomor_telepon'];
    alamat = json['alamat'];
    beratLaundry = json['berat_laundry'];
    totalHarga = json['total_harga'];
    paymentMethod = json['payment_method'];
    tanggalPemesanan = json['tanggal_pemesanan'];
    tanggalPengambilan = json['tanggal_pengambilan'];
    laundryId = json['laundry_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_pemesanan'] = this.noPemesanan;
    data['jenis_pemesanan'] = this.jenisPemesanan;
    data['nama_pemesan'] = this.namaPemesan;
    data['nomor_telepon'] = this.nomorTelepon;
    data['alamat'] = this.alamat;
    data['berat_laundry'] = this.beratLaundry;
    data['total_harga'] = this.totalHarga;
    data['payment_method'] = this.paymentMethod;
    data['tanggal_pemesanan'] = this.tanggalPemesanan;
    data['tanggal_pengambilan'] = this.tanggalPengambilan;
    data['laundry_id'] = this.laundryId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
