import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_models.freezed.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageAsset,
    required String category,
    required String badge,
  }) = _Product;
}

@freezed
abstract class BannerItem with _$BannerItem {
  const factory BannerItem({
    required String title,
    required String subtitle,
    required String imageAsset,
  }) = _BannerItem;
}

@freezed
abstract class Shop with _$Shop {
  const factory Shop({
    required String name,
    required String address,
    required String hours,
    required String imageAsset,
  }) = _Shop;
}
