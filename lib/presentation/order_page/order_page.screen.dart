import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wash_it/presentation/order_page/widgets/search_dropdown_widget.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/auth/input_form_widget.dart';
import '../../widget/common/content_title_widget.dart';
import '../../widget/common/mainpage_appbar_widget.dart';
import 'controllers/order_page.controller.dart';

class OrderView extends GetView<OrderController> {
  final String? tipeOrder;

  OrderView({Key? key, this.tipeOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    const List<String> list = <String>['Tunai', 'Non Tunai'];
    // String dropdownValue = list.first;

    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Pesan Laundry',
        onPressed: () => showExitConfirmationDialog(context),
      ),
      body: Obx(
        () => Stepper(
          stepIconHeight: 24,
          elevation: 1,
          type: StepperType.horizontal,
          steps: getSteps(context),
          currentStep: controller.currentStep.value,
          onStepContinue: null,
          onStepCancel: null,
          onStepTapped: null,
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container();
          },
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
                onPressed: () {
                  if (controller.currentStep.value > 0) {
                    controller.pageChangedMin();
                  } else {
                    showExitConfirmationDialog(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text("Kembali", style: tsBodySmallSemibold(black)),
                ),
              ),
            ),
            const SizedBox(width: defaultMargin),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF76ABAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (controller.currentStep.value <
                      getSteps(context).length - 1) {
                    controller.pageChangedPlus();
                  } else {
                    // controller.ordertype.value = tipeOrder ?? '';

                    controller.createOrder(tipeOrder.toString());
                  }
                },
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

  List<Step> getSteps(BuildContext context) => [
        Step(
          stepStyle: StepStyle(
            connectorColor: Colors.transparent,
          ),
          isActive: controller.currentStep.value >= 0,
          state: controller.currentStep.value >= 1
              ? StepState.complete
              : StepState.indexed,
          title: Text('Isi Form', style: tsLabelLargeMedium(black)),
          content: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Column(
              key: ValueKey<int>(controller.currentStep.value),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ContentTitleWidget(
                      title: "Silahkan isi data dibawah ini"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pesan untuk sendiri",
                      style: tsBodyMediumMedium(black),
                    ),
                    Switch(
                      value: controller.isSelected.value,
                      onChanged: (value) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          if (value == false) {
                            controller.nameTextController.text = "";
                            controller.phoneTextEditingController.text = "";
                          }
                          if (value == true) {
                            controller.nameTextController.text =
                                controller.userData['username'];
                            controller.phoneTextEditingController.text =
                                controller.userData['phone'];
                          }
                          controller.isSelected.value = value;
                          print(controller.isSelected.value);
                        });
                      },
                      activeColor: secondaryColor,
                      inactiveTrackColor: lightGrey,
                      inactiveThumbColor: darkGrey,
                      trackOutlineColor: WidgetStateProperty.all(lightGrey),
                      trackOutlineWidth: WidgetStateProperty.all(0),
                    ),
                  ],
                ),
                Obx(() => InputFormWidget(
                      title: "Nama Pelanggan",
                      hintText: "Masukkan nama anda",
                      controller: controller.nameTextController,
                      readOnly: controller.canContinue.value,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        controller.updateOrderName(value);
                      },
                    )),
                Obx(() => InputFormWidget(
                    title: "Nomor Telepon",
                    controller: controller.phoneTextEditingController,
                    formatter: [FilteringTextInputFormatter.digitsOnly],
                    hintText: "Masukkan nomor telepon anda",
                    readOnly: controller.canContinue.value,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      controller.updatePhoneNumber(value);
                    })),
                InputFormWidget(
                  title: "Alamat",
                  hintText: "Masukkan alamat anda",
                  controller: controller.addressTextEditingController,
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    controller.updateAddress(value);
                  },
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
        Step(
          stepStyle: StepStyle(
            connectorColor: Colors.transparent,
          ),
          isActive: controller.currentStep.value >= 1,
          state: controller.currentStep.value == 2
              ? StepState.complete
              : StepState.indexed,
          title: Text('Pilih Layanan', style: tsLabelLargeMedium(black)),
          content: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Column(
              key: ValueKey<int>(controller.currentStep.value),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ContentTitleWidget(
                      title: "Pilih layanan yang akan kamu gunakan"),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Pilih tipe laundry",
                      style: tsBodyMediumMedium(black)),
                ),
                SearchDropdownWidget(
                  hintText: "Pilih tipe laundry",
                  suggestions: controller.jenisList
                      .map((e) => SearchFieldListItem(e))
                      .toList(),
                  validator: (newValue) {
                    if (controller.jenisList.contains(newValue)) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        controller.getIdLaundries(newValue!);
                        controller.updateLaundryName(newValue);
                      });
                    } else {
                      return "Pilih tipe laundry";
                    }
                    return null;
                  },
                ),
                InputFormWidget(
                  title: "Catatan",
                  hintText: "Tambahkan catatan (opsional)",
                  onChanged: (value) {
                    controller.catatan.value = value;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Tanggal Pengambilan",
                      style: tsBodyMediumMedium(black)),
                ),
                Obx(
                  () => TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lightGrey, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '${controller.pickupdate.value}',
                      hintStyle: tsBodySmallMedium(black),
                      suffixIcon:
                          const Icon(Icons.calendar_today, color: darkGrey),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
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

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          controller.updatePickupDate('$year-$month-$day');
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
        Step(
          stepStyle: StepStyle(
            connectorColor: Colors.transparent,
          ),
          isActive: controller.currentStep.value >= 2,
          title: Text('Konfirmasi', style: tsLabelLargeMedium(black)),
          content: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Column(
              key: ValueKey<int>(controller.currentStep.value),
              children: [
                const ContentTitleWidget(
                    title: "Pastikan data kamu telah sesuai"),
                const SizedBox(height: 20),
                _buildDataBox("Data Pelanggan dan Pesanan", [
                  Text("Data Pelanggan", style: tsBodySmallSemibold(black)),
                  const SizedBox(height: 10),
                  _buildDataItem(
                    "Nama",
                    "${controller.nameTextController.text}",
                  ),
                  _buildDataItem(
                    "Nomor Telepon",
                    "${controller.phoneTextEditingController.text}",
                  ),
                  _buildDataItem(
                    "Alamat",
                    "${controller.address.value}",
                  ),
                  const SizedBox(height: 10),
                  Text("Detail Pesanan", style: tsBodySmallSemibold(black)),
                  const SizedBox(height: 10),
                  _buildDataItem(
                    "Jenis Pemesanan",
                    "${tipeOrder == 'antar_jemput' ? "Antar jemput" : "Antar mandiri"}",
                  ),
                  _buildDataItem(
                    "Tipe Laundry",
                    "${controller.laundryName}",
                  ),
                  _buildDataItem(
                    "Tanggal Pengambilan",
                    "${controller.pickupdate.value}",
                  ),
                  _buildDataItem("Catatan", "${controller.catatan.value}"),
                  const SizedBox(height: 10),
                  // DropdownMenu(
                  //   inputDecorationTheme: InputDecorationTheme(
                  //       isDense: true,
                  //       isCollapsed: true,
                  //       contentPadding: const EdgeInsets.symmetric(
                  //           vertical: 5, horizontal: 15),
                  //       constraints: BoxConstraints(minWidth: Get.width),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide(color: lightGrey, width: 1),
                  //       )),
                  //   dropdownMenuEntries: controller.paymentList
                  //       .map<DropdownMenuEntry<String>>((String value) {
                  //     return DropdownMenuEntry<String>(
                  //         value: value, label: value);
                  //   }).toList(),
                  // )
                  DropdownButtonFormField(
                    style: tsBodySmallMedium(black),
                    // borderRadius: BorderRadius.all(Radius.circular(20)),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lightGrey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("Metode Pembayaran"),
                      labelStyle: tsBodySmallMedium(darkGrey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                    ),

                    items: controller.paymentList
                        .map((item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.payment.value = value!;
                      print(value);
                    },
                  )
                ]),
                const SizedBox(height: 20),
                Text(
                  "*Untuk layanan antar jemput diwajibkan membayar biaya minimal per kg, minimal 3Kg",
                  style: tsLabelLargeMedium(darkGrey),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ];

  Widget _buildDataItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: tsBodySmallMedium(darkGrey)),
          Container(
            width: Get.width * 0.4,
            child: Text(
              value,
              style: tsBodySmallRegular(darkBlue),
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataBox(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        color: darkGrey,
        strokeWidth: 2,
        dashPattern: const [10, 5],
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Future<void> showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text(
              'Apakah Anda yakin ingin kembali ke halaman sebelumnya?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                controller.currentStep.value = 0;
                Navigator.of(dialogContext).pop();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
