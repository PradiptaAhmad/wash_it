import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/history_page/widgets/history_review_popup.dart';
import 'package:wash_it/widgets/common/main_container_widget.dart';

class MainDetailView extends StatelessWidget {
  MainDetailView({super.key, required this.order});

  final Map<String, dynamic> order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.TRANSACTION_PAGE,
            arguments: [order['id'], 'histories']),
        child: MainContainerWidget(
          childs: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "id Pesanan",
                            style: tsLabelLargeMedium(grey),
                          ),
                          Text(
                            "${order['no_pemesanan']}",
                            style: tsLabelLargeMedium(black),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString() == 'null' ? "2007-07-31 00:00:00" : order['tanggal_estimasi'].toString()))}",
                        style: tsLabelLargeMedium(darkGrey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Divider(color: lightGrey, thickness: 0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${order['nama_pemesan']}",
                            style: tsBodySmallSemibold(black),
                          ),
                          Text(
                            order['jenis_pemesanan'] == 'antar_jemput'
                                ? "Antar Jemput"
                                : "Antar Mandiri",
                            style: tsLabelLargeSemibold(darkGrey),
                          ),
                          Text(
                            order['berat_laundry'] == null
                                ? "Berat belum tercatat"
                                : "${order['berat_laundry']} Kg",
                            style: tsLabelLargeSemibold(darkGrey),
                          ),
                          Text(
                            "${order['nama_laundry']}",
                            style: tsBodySmallSemibold(successColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${order['alamat']}",
                        style: tsLabelLargeSemibold(grey),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 4,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total harga",
                            style: tsLabelMediumMedium(black),
                          ),
                          Text(
                            order['total_harga'] == null
                                ? "Harga belum tercatat"
                                : '${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(order['total_harga'])}',
                            style: tsBodySmallSemibold(black),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              showModalBottomSheet(
                                context: context,
                                enableDrag: true,
                                isDismissible: true,
                                scrollControlDisabledMaxHeightRatio: 0.45,
                                sheetAnimationStyle: AnimationStyle(
                                  duration: Durations.medium1,
                                  curve: Curves.easeInOut,
                                ),
                                backgroundColor: primaryColor,
                                isScrollControlled: true,
                                builder: (context) {
                                  return HistoryReviewPopup(id: order['id']);
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: secondaryColor.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                                child: Text(
                                  "Ulas",
                                  style: tsLabelLargeSemibold(secondaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
