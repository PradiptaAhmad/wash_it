import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/order_antarjemput/widgets/search_dropdown_widget.dart';
import 'package:wash_it/widget/common/auth/input_form_widget.dart';

class OrderPageScreen2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OrderPageScreen2({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

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
                _buildStepIndicator(
                  "✓",
                  "Isi Form",
                  true,
                ),
                _buildStepIndicator(
                  "2",
                  "Pilih Layanan",
                  true,
                ),
                _buildStepIndicator(
                  "3",
                  "Konfirmasi",
                  false,
                ),
              ],
            ),
            SizedBox(height: 30),
            Text("Pilih layanan yang akan anda gunakan",
                style: tsBodyMediumSemibold(black)),
            SizedBox(height: 10),
            Text(
              "Pilih tipe laundry",
              style: tsBodyMediumMedium(black),
            ),
            SizedBox(height: 10),
            SearchDropdownWidget(
              // hintTecy: "Tipe Laundry",
              hintText: "Pilih tipe laundry",
              suggestions: ["Cuci Kering", "Cuci Basah", "Setrika"]
                  .map((e) => SearchFieldListItem(e))
                  .toList(),
            ),
            InputFormWidget(
              title: "Catatan",
              hintText: "Tambahkan catatan (opsional)",
            ),
            SizedBox(height: 20),
            Text(
              "Tanggal Pengambilan",
              style: tsBodyMediumMedium(black),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: lightGrey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(),
                hintText: 'Pilih tanggal',
                hintStyle: tsBodySmallMedium(darkGrey),
                suffixIcon: Icon(Icons.calendar_today, color: darkGrey),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 15),
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
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF535C6B),
                  backgroundColor: Color(0xFFE1E3E7), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onBack,
                child: Text("Kembali"),
              ),
            ),
            SizedBox(width: defaultMargin), // Add some space (horizontal space
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF76ABAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onNext,
                child:
                    Text("Selanjutnya", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStepIndicator(String number, String text, bool isActive) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 25, // Smaller circle
            height: 25,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF767676), width: 1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(number,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.black : Color(0xFF767676))),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      color: Color(0xFF767676),
                      fontSize: 14))), // Smaller text for steps
        ],
      ),
    );
  }
}
