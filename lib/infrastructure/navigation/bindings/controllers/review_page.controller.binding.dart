import 'package:get/get.dart';

import '../../../../presentation/review_page/controllers/review_page.controller.dart';

class ReviewPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewPageController>(
      () => ReviewPageController(),
    );
  }
}
