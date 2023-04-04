import 'package:get/get.dart';

class TabsController extends GetxController {
  // add a dict-ionary to store the products in the cart
  final RxInt _tabs = 0.obs;

  void setTabId(int index) {
    _tabs.value = index;
  }

  get tabId => _tabs.toInt();
}
