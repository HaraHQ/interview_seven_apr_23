import 'package:get/get.dart';
import 'package:untuk_interview/model/product.dart';

class CartController extends GetxController {
  // add a dict-ionary to store the products in the cart
  final _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added",
      "This ${product.name} is added to cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(
        seconds: 2,
      ),
    );
  }

  get carts => _products;

  get subTotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get totalCount => _products.entries
      .map((product) => product.value ?? 0)
      .toList()
      .reduce((value, element) => value + element);

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element);
}
