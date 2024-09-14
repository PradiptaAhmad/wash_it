import 'dart:convert';
import 'dart:async'; // Import for Timer

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';
import '../../../widgets/popup/custom_pop_up.dart';

class ChatPageController extends GetxController {
  var messagesData = [].obs;
  var isLoading = false.obs;
  final count = 0.obs;
  late final WebSocketChannel? channel;
  late final Timer _pingTimer;

  final ScrollController scrollController = ScrollController();
  late final userId;
  late final userDetailData = {}.obs;
  final box = GetStorage();

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> fetchMessageData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/message/get?&page=1"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        messagesData.addAll(jsonDecode(response.body)['data']);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data obrolan', warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addMessage(String message) async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      var dataShow = {
        'to_user_id': 'admin',
        'from_user_id': userId.toString(),
        'message': message.toString(),
        'created_at': DateTime.now().toString(),
      };
      var data = {
        'message': message.toString(),
      };
      messagesData.insert(0, dataShow);
      final response = await http.post(
        Uri.parse("${url}/message/send"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 201) {
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, Gagal untuk mengirim pesan', warningColor);
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void subscribeToChannel() {
    var channelName = {
      "channel": "chat.$userId",
    };

    if (channel != null) {
      final subscribeMessage = {
        "event": "pusher:subscribe",
        "data": channelName,
      };
      channel!.sink.add(jsonEncode(subscribeMessage));
    }
  }

  void sendPing() {
    if (channel != null) {
      final pingMessage = {
        "event": "pusher:ping",
        "data": {},
      };
      channel!.sink.add(jsonEncode(pingMessage));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    userId = Get.arguments[0];
    userDetailData.value = {
      'username': Get.arguments[1],
      'image_path': Get.arguments[2],
    };
    channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.laundrynaruto.my.id/app/5pmjmmvbf0kekaxxf9ks'));
    subscribeToChannel();
    await fetchMessageData();
    _pingTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      sendPing();
    });
  }

  @override
  void onClose() {
    super.onClose();
    channel!.sink.close();
    _pingTimer.cancel();
  }

  void increment() => count.value++;
}
