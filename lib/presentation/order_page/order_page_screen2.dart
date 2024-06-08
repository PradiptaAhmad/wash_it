import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/order_page/widgets/search_dropdown_widget.dart';
import 'package:wash_it/widget/common/auth/input_form_widget.dart';
import 'package:get/get.dart';

import '../../widget/common/content_title_widget.dart';
import 'controllers/order_page.controller.dart';

class OrderPageScreen2 extends GetView<OrderAntarJemputController> {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OrderPageScreen2({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: primaryColor,
        title: Text("Pesan Laundry", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepIndicator("✓", "Isi Form", true),
                _buildStepIndicator("2", "Pilih Layanan", true),
                _buildStepIndicator("3", "Konfirmasi", false),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ContentTitleWidget(
                  title: "Pilih layanan yang akan kamu gunakan"),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Text("Pilih tipe laundry", style: tsBodyMediumMedium(black)),
            ),
            SearchDropdownWidget(
              hintText: "Pilih tipe laundry",
              suggestions: controller.jenisList
                  .map((e) => SearchFieldListItem(e))
                  .toList(),
              validator: (newValue) {
                if (controller.jenisList.contains(newValue)) {
                  controller.getIdLaundries(newValue!);
                  controller.updateOrderType(newValue!);
                } else {
                  return "Pilih tipe laundry";
                }

                return null;
              },
            ),
            InputFormWidget(
              title: "Catatan",
              hintText: "Tambahkan catatan (opsional)",
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Text("Tanggal Pengambilan", style: tsBodyMediumMedium(black)),
            ),
            Obx(
              () => TextField(
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(),
                  hintText: '${controller.pickupdate.value}',
                  hintStyle: tsBodySmallMedium(black),
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
                    int year = pickedDate.year;
                    int month = pickedDate.month;
                    int day = pickedDate.day;

                    controller.updatePickupDate('$year-$month-$day');
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onBack,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text("Kembali", style: tsBodySmallSemibold(black)),
                ),
              ),
            ),
            SizedBox(width: defaultMargin), // Add some space (horizontal space)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF76ABAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onNext,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text("Selanjutnya",
                      style: tsBodySmallSemibold(primaryColor)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStepIndicator(String number, String text, bool isActive) {
    return Container(
      child: Row(
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
          SizedBox(width: 5),
          Text(text, style: tsLabelLargeMedium(black)) // Smaller text for steps
        ],
      ),
    );
  }
}
