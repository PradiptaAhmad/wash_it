import 'package:flutter/material.dart';

class OrderPageScreen1 extends StatelessWidget {
  final VoidCallback onNext;

  const OrderPageScreen1({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Pesan Laundry", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildStepIndicator("1", "Isi Form", true),
                _buildStepIndicator("2", "Pilih Layanan", false),
                _buildStepIndicator("3", "Konfirmasi", false),
              ],
            ),
            SizedBox(height: 30),
            Text("Silahkan isi data dibawah ini", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Nama Pelanggan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama Anda',
                isDense: true,  // Reduces the height
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),  // Reduces padding inside the field
              ),
            ),
            SizedBox(height: 15),
            Text("Nomor Telepon", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nomor telepon Anda',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 15),
            Text("Alamat", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan alamat lengkap Anda',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF535C6B), backgroundColor: Color(0xFFE1E3E7), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
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
                    onPressed: onNext,
                    child: Text("Selanjutnya", style: TextStyle(color: Colors.white)),
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
            width: 25,  // Smaller circle
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
          Expanded(child: Text(text, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: Color(0xFF767676), fontSize: 14))),  // Smaller text for steps
        ],
      ),
    );
  }
}
