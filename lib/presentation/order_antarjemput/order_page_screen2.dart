import 'package:flutter/material.dart';

class OrderPageScreen2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OrderPageScreen2({Key? key, required this.onNext, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: onBack,
        ),
        title: Text("Pilih Layanan", style: TextStyle(color: Colors.black)),
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
                _buildStepIndicator("✓", "Isi Form", true,),
                _buildStepIndicator("2", "Pilih Layanan", true, ),
                _buildStepIndicator("3", "Konfirmasi", false, ),
              ],
            ),
            SizedBox(height: 30),
            Text("Pilih layanan yang akan anda gunakan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Pilih tipe laundry", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              items: <String>['Cuci reguler', 'Cuci kering', 'Cuci setrika'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih jenis layanan',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
            ),
            SizedBox(height: 20),
            Text("Catatan", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tambahkan catatan (opsional)',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Text("Jadwalkan laundrymu untuk diambil", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih tanggal',
                suffixIcon: Icon(Icons.calendar_today),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  // Logic to save or use the selected date
                }
              },
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
