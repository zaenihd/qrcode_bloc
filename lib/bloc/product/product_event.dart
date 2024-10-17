part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductEventAddProduct extends ProductEvent {
  final String name;
  final String code;
  final int qty;

  ProductEventAddProduct(
      {required this.name, required this.code, required this.qty});
}

class ProductEventEditProduct extends ProductEvent {
  final String name;
  final String productId;
  final int qty;

  ProductEventEditProduct(
      {required this.name, required this.productId, required this.qty});
}

class ProductEventDeleteProduct extends ProductEvent {
  final String id;

  ProductEventDeleteProduct({required this.id});
}
class ProductEventExportPdfProduct extends ProductEvent {
}
