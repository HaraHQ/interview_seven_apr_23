import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:untuk_interview/controllers/cart.dart';
import 'package:untuk_interview/controllers/tabs.dart';
import 'package:untuk_interview/model/product.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final tabsController = Get.put(TabsController());
  final cartController = Get.put(CartController());

  MainApp({super.key});

  final List<Widget> _views = [
    const OrderView(), // 0 \
    BillView(), // 1   > cores
    UserView(), // 2  /
    UserRegisterView(), // 3 - extra
    UserProfileView(), // 4 extra
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        floatingActionButton: Obx(() => Visibility(
              visible: cartController.carts.length > 0,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green,
                onPressed: () {
                  tabsController.setTabId(1);
                },
                label: Obx(
                  () => Row(
                    children: [
                      const Icon(Icons.badge),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Order Quantity'),
                          Text(cartController.carts.length > 0
                              ? '${cartController.totalCount} item(s)'
                              : '0 item'),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(cartController.carts.length > 0
                          ? 'Rp ${cartController.total}'
                          : 'Rp 0'),
                    ],
                  ),
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.payments_outlined),
                  label: 'Order',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.topic),
                  label: 'Bills',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle),
                  label: 'User',
                ),
              ],
              currentIndex:
                  tabsController.tabId == 3 || tabsController.tabId == 4
                      ? 2
                      : tabsController.tabId == 5
                          ? 1
                          : tabsController.tabId,
              selectedItemColor: Colors.amber[800],
              onTap: (int id) {
                tabsController.setTabId(id);
              },
            )),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              tabsController.setTabId(0);
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text('Restaurant Name'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Obx(
          () => _views.elementAt(tabsController.tabId),
        ),
      ),
    );
  }
}

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  Future showBanner(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    // ignore: use_build_context_synchronously
    PopupBanner(
      height: 300,
      fit: BoxFit.fitWidth,
      context: context,
      images: [
        "https://cdn.pixabay.com/photo/2022/11/23/18/31/birds-7612651_1280.png",
      ],
      useDots: false,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    showBanner(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          'https://cdn.pixabay.com/photo/2023/03/28/09/28/cat-7882701_1280.jpg',
          height: 275,
        ),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Category',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: Product.products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(index: index);
            },
          ),
        ),
      ],
    );
  }
}

class BillView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  BillView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 100),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => cartController.carts.length > 0
                  ? ListView.builder(
                      itemCount: cartController.carts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BillCard(
                            controller: cartController,
                            product: cartController.carts.keys.toList()[index],
                            quantity:
                                cartController.carts.values.toList()[index],
                            index: index);
                      },
                    )
                  : const Text('Tidak ada product di bill'),
            ),
          ),
          BillTotal(
            controller: cartController,
            total: 10,
          ),
        ],
      ),
    );
  }
}

class BillCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;

  const BillCard(
      {super.key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.name),
          Text('${quantity.toString()}x'),
          Text((quantity * product.price).toString())
        ],
      ),
    );
  }
}

class BillTotal extends StatelessWidget {
  final CartController controller;
  final int total;

  const BillTotal({super.key, required this.controller, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total:'),
        Obx(() => Text(
            controller.carts.length > 0 ? controller.total.toString() : '0')),
      ],
    );
  }
}

class UserView extends StatelessWidget {
  final tabsController = Get.put(TabsController());

  UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Phone Number',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    tabsController.setTabId(3); // access the 4th entity
                  },
                  child: const Text(
                    'Sign Up',
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    tabsController.setTabId(4);
                  },
                  child: const Text(
                    'Sign In',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserRegisterView extends StatelessWidget {
  final tabsController = Get.put(TabsController());

  UserRegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Phone Number',
            ),
          ),
          Row(children: [
            Expanded(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(value: "USA", child: Text("0-10")),
                  DropdownMenuItem(value: "Canada", child: Text("11-21")),
                  DropdownMenuItem(value: "Brazil", child: Text("21-35")),
                  DropdownMenuItem(value: "England", child: Text("35++")),
                ],
                onChanged: (newVal) {},
                hint: const Text('Usia'),
                isExpanded: true,
              ),
            ),
            Expanded(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(value: "USA", child: Text("Male")),
                  DropdownMenuItem(value: "Canada", child: Text("Female")),
                  DropdownMenuItem(value: "Brazil", child: Text("Robot")),
                  DropdownMenuItem(value: "England", child: Text("Dunno")),
                ],
                onChanged: (newVal) {},
                hint: const Text('Gender'),
                isExpanded: true,
              ),
            ),
          ]),
          DropdownButton(
            items: const [
              DropdownMenuItem(value: "USA", child: Text("Banten")),
              DropdownMenuItem(value: "Canada", child: Text("Jakarta")),
              DropdownMenuItem(value: "Brazil", child: Text("Bandung")),
              DropdownMenuItem(value: "England", child: Text("Sekitarnya")),
            ],
            onChanged: (newVal) {},
            hint: const Text('Provinsi'),
            isExpanded: true,
          ),
          Row(children: [
            Expanded(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(value: "USA", child: Text("Serang")),
                  DropdownMenuItem(value: "Canada", child: Text("Cilegon")),
                  DropdownMenuItem(value: "Brazil", child: Text("Tangerang")),
                  DropdownMenuItem(value: "England", child: Text("Pandeglang")),
                ],
                onChanged: (newVal) {},
                hint: const Text('Kota'),
                isExpanded: true,
              ),
            ),
            Expanded(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(value: "USA", child: Text("Cipocok Jaya")),
                  DropdownMenuItem(value: "Canada", child: Text("Taktakan")),
                  DropdownMenuItem(value: "Brazil", child: Text("Selaya")),
                  DropdownMenuItem(
                      value: "England", child: Text("Banjar Agung")),
                ],
                onChanged: (newVal) {},
                hint: const Text('Kabupaten'),
                isExpanded: true,
              ),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    tabsController.setTabId(2);
                  },
                  child: const Text('Sign Up'))
            ],
          ),
        ],
      ),
    );
  }
}

class UserProfileView extends StatelessWidget {
  final tabsController = Get.put(TabsController());

  UserProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            color: Colors.grey.shade300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ID: +62'),
                Text(
                  'Update Security - Claim Point',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(children: const [
                  Text(
                    '⭐',
                    style: TextStyle(fontSize: 72),
                  ),
                  Text('1/99'),
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('REWARDS'),
                  Text('Gold Level 1'),
                  Text(
                    '1',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text('star until'),
                  Text('next reward'),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rewards',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      8,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.network(
                          'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/3/29/b55bcdf2-b0ad-4583-99d1-4a776a9d1d4e.png',
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Promotions',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      8,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.network(
                          'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/3/29/b55bcdf2-b0ad-4583-99d1-4a776a9d1d4e.png',
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final int index;
  ProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.network(
                'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/3/29/b55bcdf2-b0ad-4583-99d1-4a776a9d1d4e.png',
                width: 64,
                height: 64,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(Product.products[index].name),
                      const Spacer(),
                      Text(Product.products[index].price.toString())
                    ],
                  ),
                  Text(Product.products[index].description),
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black87,
                        ),
                        child: TextButton(
                          onPressed: () {
                            cartController.addProduct(Product.products[index]);
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
