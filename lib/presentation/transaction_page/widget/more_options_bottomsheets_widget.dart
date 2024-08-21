import 'package:flutter/material.dart';
import 'package:wash_it/presentation/transaction_page/controllers/transaction_page.controller.dart';

import '../../../infrastructure/theme/themes.dart';

Future moreOptionsBottomsheetsWidget(
    context, TransactionPageController controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    scrollControlDisabledMaxHeightRatio: 0.11,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close_rounded, color: black)),
                SizedBox(width: 10),
                Text("Lainnya", style: tsBodyMediumMedium(black)),
              ],
            ),
            SizedBox(height: defaultMargin),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text(
                          'Apakah Anda yakin ingin membatalkan pesanan ini?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Batal'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Ya'),
                          onPressed: () {
                            controller.putOrderCancel();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 28,
                child: Text("Batalkan pesanan",
                    style: tsBodySmallMedium(warningColor)),
              ),
            )
          ],
        ),
      );
    },
  );
}
