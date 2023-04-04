
class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  static const List<Product> products = [
    Product(
      id: 1,
      name: 'Kwetiau Sapi Kuah',
      imageUrl: 'assets/image/food_a.png',
      description:
          'makanan yang terbuat dari tepung beras yang dimasak dengan kuah yang gurih dilengkapi topping daging sapi dan juga bakso dan sosis sapi.',
      price: 20000.0,
    ),
    Product(
      id: 2,
      name: 'Bakso Sapi Iga',
      imageUrl: 'assets/image/food_b.png',
      description:
          'bakso yang kenyal dan ngelawan, disukai kaum muda yang gigi nya masih sehat, tapi ada tetelan sapi dan iga yang lembut membuat para orang tua juga menyukainya',
      price: 30000.0,
    ),
    Product(
      id: 3,
      name: 'Tom Yum Singapur',
      imageUrl: 'assets/image/food_c.png',
      description:
          'rempah-rempah ala asia tenggara yang telah diolah para chef ahli di singapur, membuat masakan lezat ini beserta seafood yang diolah langsung tidak kaleng-kalengan',
      price: 40000.0,
    ),
    Product(
      id: 4,
      name: 'Kensos Betawi',
      imageUrl: 'assets/image/food_d.png',
      description:
          'kentang dan sosis, seperti mas mandra dan mas karyo, berbeda tapi tetep asik di tongkrongan',
      price: 50000.0,
    ),
    Product(
      id: 5,
      name: 'Kwetiau Ayam Bulgogi',
      imageUrl: 'assets/image/food_e.png',
      description:
          'makanan fusion dari china dan korea, nikmati lembutnya kwetiau dengan saus manis dan kuah bercampur daging sapi kualitas tinggi',
      price: 20000.0,
    ),
    Product(
      id: 6,
      name: 'Duckling Cordon Bleu',
      imageUrl: 'assets/image/food_f.png',
      description:
          'bosan makan ayam sekena nya dengan satu slice daging dan saus keju ? nikmati olahan terbaru kami dengan daging bebek peking dan nikmatnya mozarella',
      price: 30000.0,
    ),
    Product(
      id: 7,
      name: 'Bapau Rakshesa',
      imageUrl: 'assets/image/food_g.png',
      description:
          'bapau dengan ukuran super jumbo yang meniadakan lapar, dengan kumbu kacang merah yang legit membuat mata melongo',
      price: 40000.0,
    ),
    Product(
      id: 8,
      name: 'Apple-pine Pie',
      imageUrl: 'assets/image/food_h.png',
      description:
          'kalo udah biasa makan apple pie, kali ini lembut nya saus apple di campur dengan lezat nya selai homemade yang terbuat dari nanas pilihan, bikin cetar',
      price: 50000.0,
    ),
  ];
}
