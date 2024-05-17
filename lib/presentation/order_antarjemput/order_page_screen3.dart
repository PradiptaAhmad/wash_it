import 'package:flutter/material.dart';

class OrderPageScreen3 extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onFinish;
  final String nama;
  final String nomorTelepon;
  final String alamat;
  final String tipeLaundry;
  final String catatan;
  final DateTime jadwalPengambilan;
  final double hargaPerKg;

  const OrderPageScreen3({
    Key? key,
    required this.onBack,
    required this.onFinish,
    required this.nama,
    required this.nomorTelepon,
    required this.alamat,
    required this.tipeLaundry,
    required this.catatan,
    required this.jadwalPengambilan,
    required this.hargaPerKg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: onBack,
        ),
        title: Text("Konfirmasi Pesanan", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildStepIndicator("✓", "Isi Form", true),
                _buildStepIndicator("✓", "Pilih Layanan", true),
                _buildStepIndicator("3", "Konfirmasi", false),
              ],
            ),
            SizedBox(height: 30),
            Text("Pastikan data kamu telah sesuai", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildDataBox("Data Pelanggan dan Pesanan", [
              _buildDataItem("Nama", nama),
              _buildDataItem("Nomor Telepon", nomorTelepon),
              _buildDataItem("Alamat", alamat),
              _buildDataItem("Tipe Laundry", tipeLaundry),
              _buildDataItem("Catatan", catatan),
              _buildDataItem("Jadwal Pengambilan", "${jadwalPengambilan.day}/${jadwalPengambilan.month}/${jadwalPengambilan.year}"),
              _buildDataItemBold("Harga Per Kg", "Rp. ${hargaPerKg.toStringAsFixed(2)}"),
            ]),
            SizedBox(height: 20),
            Text(
              "*Untuk layanan antar jemput diwajibkan membayar biaya minimal per kg",
              style: TextStyle(color: Color(0xFF535C6B)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF535C6B),
                      backgroundColor: Color(0xFFE1E3E7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: onBack,
                    child: Text("Kembali"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF76ABAE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: onFinish,
                    child: Text("Selesai", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(String number, String text, bool isActive) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF767676), width: 1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(number, style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.black : Color(0xFF767676))),
            ),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: Color(0xFF767676), fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildDataBox(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF767676)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDataItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(label + ":", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildDataItemBold(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(label + ":", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
