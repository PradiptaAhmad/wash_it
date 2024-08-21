import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:smart_snackbars/enums/animate_from.dart';
import 'package:smart_snackbars/smart_snackbars.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';

Future<void> customPopUp(title, color) async {
  return SmartSnackBars.showTemplatedSnackbar(
    context: Get.overlayContext!,
    backgroundColor: color,
    animateFrom: AnimateFrom.fromBottom,
    animationCurve: Curves.easeInOut,
    // distanceToTravel: 60,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    title: "${title}",
    titleStyle: tsLabelLargeRegular(primaryColor),
  );
}
