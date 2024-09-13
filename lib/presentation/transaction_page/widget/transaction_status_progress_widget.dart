import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/presentation/transaction_page/controllers/transaction_page.controller.dart';

import '../../../infrastructure/theme/themes.dart';

class TransactionStatusProgressWidget
    extends GetView<TransactionPageController> {
  const TransactionStatusProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var antarJemputDesc;
    var antarMandiriDesc;

    switch (controller.statusList['status_code']) {
      case 1:
        antarJemputDesc = "Mohon tunggu untuk di konfirmasi";
        antarMandiriDesc = "Mohon tunggu untuk di konfirmasi";
        break;
      case 2:
        antarJemputDesc = "Mulai siapkan laundry dan silahkan menunggu kurir";
        antarMandiriDesc = "Mulai siapkan laundry dan antar ke tempat laundry";
        break;
      case 3:
        antarJemputDesc = "Mohon tunggu, Laundry sedang di proses";
        antarMandiriDesc = "Mohon tunggu, Laundry sedang di proses";
        break;
      case 4:
        antarJemputDesc =
            "Pesanan selesai, kurir akan mengantar ke tempat kamu";
        antarMandiriDesc = "Pesanan selesai kamu boleh mengambilnya";
        break;
      case 5:
        antarJemputDesc = "Pesanan sudah berakhir";
        antarMandiriDesc = "Pesanan sudah berakhir";
        break;
      default:
        antarJemputDesc = "Pesanan Diterima";
        antarMandiriDesc = "Pesanan Diterima";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0,
            end: controller.statusList['status_code'] / 5,
          ),
          duration: Duration(seconds: 2),
          builder: (context, value, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  stops: [value, value],
                  colors: [successColor, lightGrey],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(rect);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIcon(Iconsax.receipt),
                  buildDottedLine(),
                  buildIcon(Iconsax.box),
                  buildDottedLine(),
                  buildIcon(Iconsax.bubble),
                  buildDottedLine(),
                  buildIcon(Iconsax.truck_fast),
                  buildDottedLine(),
                  buildIcon(Iconsax.verify),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 10),
        Text(
          "${controller.statusList['status_description']}",
          style: tsBodySmallMedium(black),
          textAlign: TextAlign.center,
        ),
        Text(
          controller.ordersList['jenis_pemesanan'] == "antar_jemput"
              ? antarJemputDesc
              : antarMandiriDesc,
          style: tsLabelLargeMedium(darkGrey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 30,
      color: lightGrey,
    );
  }

  Widget buildDottedLine() {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: 40,
      lineThickness: 2,
      dashLength: 5,
      dashColor: lightGrey,
    );
  }
}
