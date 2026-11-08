import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_assets.dart';
import '../models/catalog_models.dart';

final productsProvider = Provider<List<Product>>(
  (ref) => const [
    Product(
      id: 'strawberry-cloud',
      name: 'Strawberry Cloud',
      description: 'A pillowy vanilla ring dipped in strawberry glaze and finished with a little shower of sprinkles.',
      price: 3500,
      imageAsset: AppAssets.donut1,
      category: 'Best Seller',
      badge: 'BEST SELLER',
    ),
    Product(
      id: 'choco-dream',
      name: 'Choco Dream',
      description: 'Soft-baked dough with a silky chocolate glaze and a generous cocoa finish.',
      price: 4000,
      imageAsset: AppAssets.donut2,
      category: 'Donuts',
      badge: 'FAN FAVOURITE',
    ),
    Product(
      id: 'pink-velvet',
      name: 'Pink Velvet',
      description: 'Our signature fluffy doughnut topped with a bright, fruity pink glaze.',
      price: 3800,
      imageAsset: AppAssets.donut1,
      category: 'Donuts',
      badge: 'FRESH TODAY',
    ),
    Product(
      id: 'double-chocolate',
      name: 'Double Chocolate',
      description: 'A rich chocolate treat with a tender center and smooth chocolate topping.',
      price: 4500,
      imageAsset: AppAssets.donut2,
      category: 'Best Seller',
      badge: 'BEST SELLER',
    ),
  ],
);

final bannersProvider = Provider<List<BannerItem>>(
  (ref) => const [
    BannerItem(
      title: 'A little joy\nin every bite',
      subtitle: 'Freshly made, just for you',
      imageAsset: AppAssets.banner1,
    ),
    BannerItem(
      title: 'Sweeten your\nafternoon',
      subtitle: 'Pick your new favourite today',
      imageAsset: AppAssets.banner2,
    ),
  ],
);

final shopsProvider = Provider<List<Shop>>(
  (ref) => const [
    Shop(
      name: 'J’Donuts · Downtown',
      address: 'No. 24, Merchant Road, Yangon',
      hours: 'Open today · 8:00 AM – 9:00 PM',
      imageAsset: AppAssets.shop1,
    ),
    Shop(
      name: 'J’Donuts · Riverside',
      address: '5 Strand Road, Yangon',
      hours: 'Open today · 9:00 AM – 10:00 PM',
      imageAsset: AppAssets.shop2,
    ),
  ],
);

final cartCountProvider = NotifierProvider<CartCountController, int>(
  CartCountController.new,
);

class CartCountController extends Notifier<int> {
  @override
  int build() => 0;

  void add() => state++;
}
